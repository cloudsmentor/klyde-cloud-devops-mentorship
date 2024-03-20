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
#        Subnet        #
########################
locals {
  cidr_blocks = var.subnet_cidrs

  subnets = { for i, az in data.aws_availability_zones.available.names : az => element(local.cidr_blocks, i) }
}

module "subnets" {
  source = "git@github.com:Klyde-Moradeyo/terraform-modules.git//modules/aws/subnet?ref=dev"

  name    = var.name
  vpc_id  = module.vpc.vpc_id
  subnets = local.subnets
  map_public_ip_on_launch = true
  
  tags = module.tags.tags
}

########################
#    Route Table       #
########################
module "route_table" {
  source = "git@github.com:Klyde-Moradeyo/terraform-modules.git//modules/aws/route-table?ref=dev"

  name   = var.name
  vpc_id = module.vpc.vpc_id
  routes = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = module.internet_gateway.internet_gateway_id
    }
  ]
  subnets = module.subnets.subnet_ids

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

########################
#      NAT Gateway     #
########################

########################
#    Security Group    #
########################
module "security_group" {
  source = "git@github.com:Klyde-Moradeyo/terraform-modules.git//modules/aws/security-group?ref=dev"

  name   = var.name
  vpc_id = module.vpc.vpc_id
  tags   = module.tags.tags

  ingress_rules = [
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      description      = "SSH access from anywhere"
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