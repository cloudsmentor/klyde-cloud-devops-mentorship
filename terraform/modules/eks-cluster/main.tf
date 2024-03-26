########################
#   Resource Naming    #
########################
module "resource_name_prefix" {
  source = "../resource-name-prefix"

  name = var.name
  tags = var.tags
}

########################
#         EKS          #
########################
locals {
  cluster_name = "${module.resource_name_prefix.resource_name}-eks"
}

resource "aws_eks_cluster" "cluster" {
  depends_on = [module.eks_cluster_iam_role]

  name     = local.cluster_name
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

resource "aws_eks_addon" "addons" {
  for_each = { for idx, addon in var.eks_addons : idx => addon }

  cluster_name                = aws_eks_cluster.cluster.name
  addon_name                  = each.value.name
  addon_version               = each.value.version
  service_account_role_arn    = each.value.service_account_role_arn != "" ? each.value.service_account_role_arn : null
  resolve_conflicts_on_create = each.value.resolve_conflicts_on_create != "" ? each.value.resolve_conflicts_on_create : null
  resolve_conflicts_on_update = each.value.resolve_conflicts_on_update != "" ? each.value.resolve_conflicts_on_update : null

  tags = var.tags
}



