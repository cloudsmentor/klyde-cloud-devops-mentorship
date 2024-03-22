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
  cluster_name = "${module.resource_name_prefix.resource_name}-eks"
}

resource "aws_eks_cluster" "cluster" {
  depends_on = [ module.eks_cluster_iam_role ]

  name     =  local.cluster_name
  role_arn = module.eks_cluster_iam_role.iam_role_arn

  vpc_config {
    subnet_ids              = var.subnet_ids
    security_group_ids      = var.security_group_ids
    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
    public_access_cidrs     = var.public_access_cidrs
  }
  
  tags = var.tags
}
