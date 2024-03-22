########################
#        VPC           #
########################
module "vpc" {
  source = "git@github.com:Klyde-Moradeyo/terraform-modules.git//modules/aws/vpc?ref=dev"

  name     = var.name
  vpc_cidr = var.vpc_cidr
  tags     = module.tags.tags
}

########################
#        Subnets        #
########################
locals {
  public_subnets  = { for i, az in data.aws_availability_zones.available.names : az => element(var.public_subnet_cidrs, i) }
  private_subnets = { for i, az in data.aws_availability_zones.available.names : az => element(var.private_subnet_cidrs, i) }
}

module "private_subnets" {
  source = "git@github.com:Klyde-Moradeyo/terraform-modules.git//modules/aws/subnet?ref=dev"

  name                    = var.name
  vpc_id                  = module.vpc.vpc_id
  subnets                 = local.private_subnets
  map_public_ip_on_launch = false

  tags = module.tags.tags
}

module "public_subnets" {
  source = "git@github.com:Klyde-Moradeyo/terraform-modules.git//modules/aws/subnet?ref=dev"

  name                    = var.name
  vpc_id                  = module.vpc.vpc_id
  subnets                 = local.public_subnets
  map_public_ip_on_launch = true

  tags = module.tags.tags
}

########################
#    Route Table       #
########################
module "public_route_table" {
  source = "./modules/route-table"

  name   = var.name
  vpc_id = module.vpc.vpc_id
  routes = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = module.internet_gateway.internet_gateway_id
    }
  ]
  subnets = module.public_subnets.subnet_ids

  tags = module.tags.tags
}

module "private_route_table" {
  source = "./modules/route-table"

  name   = var.name
  vpc_id = module.vpc.vpc_id
  routes = [{
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = module.nat_gateway.nat_gateway_id
  }]
  subnets = module.private_subnets.subnet_ids

  tags = module.tags.tags
}

########################
#   Internet Gateway   #
########################
module "internet_gateway" {
  source = "git@github.com:Klyde-Moradeyo/terraform-modules.git//modules/aws/internet-gateway?ref=dev"

  name   = var.name
  vpc_id = module.vpc.vpc_id
  tags   = module.tags.tags
}

#########################
#     EIP for NAT       #
#########################
# module "eip" {
#   source = "./modules/eip"

#   name = var.name

#   tags = module.tags.tags
# }

########################
#      NAT Gateway     #
########################
module "nat_gateway" {
  source = "./modules/nat-gateway"

  name = var.name

  subnet_id     = module.private_subnets.subnet_ids[0]

  tags = module.tags.tags
}

########################
# Cluster Security Grp #
########################
module "cluster_sg" {
  source = "./modules/security-group"

  name   = "${var.name}-eks-cluster"
  vpc_id = module.vpc.vpc_id
  tags   = module.tags.tags

  ingress_rules = [
    {
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = []
      security_groups  = [module.worker_node_sg.security_group_id]
      ipv6_cidr_blocks = []
      description      = "Allow Inbound HTTPS Traffic to Control Plane"
    },
    {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = []
      security_groups  = [module.worker_node_sg.security_group_id]
      ipv6_cidr_blocks = []
      description      = "Allow worker nodes to communicate with the cluster API Server"
    }
  ]

  egress_rules = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      description      = "Allow all outbound traffic"
    },
  ]
}

########################
# Worker Security Grp  #
########################
module "worker_node_sg" {
  source = "./modules/security-group"

  name   = "${var.name}-eks-worker-node"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      description      = "SSH access to worker nodes from anywhere"
    },
    {
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      description      = "Allow woker nodes to communicate with each other"
      self             = true
    }
  ]

  egress_rules = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      description      = "Allow all outbound traffic"
    }
  ]

  tags = module.tags.tags
}

resource "aws_security_group_rule" "cluster_to_worker_nodes" {
  type                     = "ingress"
  description              = "Allow worker nodes to receive communication from the cluster control plane"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = module.worker_node_sg.security_group_id
  source_security_group_id = module.cluster_sg.security_group_id
}