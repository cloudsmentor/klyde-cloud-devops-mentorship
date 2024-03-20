########################
#   Resource Naming    #
########################
module "resource_name_prefix" {
  source  = "../resource-name-prefix"

  name = var.name
  tags   = var.tags
}

########################
#         EKS          #
########################
locals {
  cluster_name = "${module.resource_name_prefix.resource_name}"
  node_group_name = "${module.resource_name_prefix.resource_name}-node-grp"
}

resource "aws_eks_cluster" "cluster" {
  depends_on = [ module.eks_node_iam_role ]

  name     =  local.cluster_name
  role_arn = module.eks_cluster_iam_role.iam_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
  
  tags = var.tags
}

resource "time_sleep" "wait_after_cluster_creation" {
  depends_on = [aws_eks_cluster.cluster]

  create_duration = "5s" # "600s"
}

resource "aws_eks_node_group" "node_group" {
  depends_on = [ module.eks_node_iam_role, time_sleep.wait_after_cluster_creation ]
  cluster_name    = local.cluster_name
  node_group_name = local.node_group_name
  node_role_arn   = module.eks_node_iam_role.iam_role_arn
  version        = var.kubernetes_version
  subnet_ids      = var.subnet_ids
  labels         = var.node_labels

  ami_type        = var.ami_type
  instance_types  = var.instance_types
  capacity_type   = var.capacity_type

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size,
    ]
  }

  dynamic "update_config" {
    for_each = var.max_unavailable_percentage != null ? [1] : []
    content {
      max_unavailable_percentage = var.max_unavailable_percentage
    }
  }

  dynamic "remote_access" {
    for_each = var.remote_access_ssh_key_name != null ? [1] : []
    content {
      ec2_ssh_key               = var.remote_access_ssh_key_name
      source_security_group_ids = var.remote_access_source_security_groups
    }
  }

  tags = var.tags
}

