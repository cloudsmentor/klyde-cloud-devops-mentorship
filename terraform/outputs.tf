output "ecr_repo_name" {
  value = module.ecr.repository_name
}

output "ecr_repo_url" {
  value = module.ecr.repository_url
}

output "eks_cluster_name" {
  value = module.eks_cluster.eks_cluster_name
}

output "eks_addons_details" {
  value = module.eks_cluster.eks_addons_details
}

output "gh_action_iam_role_arn" {
  value = module.gh_action_iam_role.iam_role_arn
}