output "ecr_repo_name" {
  value = module.ecr.repository_name
}

output "ecr_repo_url" {
  value = module.ecr.repository_url
}

output "gh_action_iam_role_arn" {
  value = module.gh_action_iam_role.iam_role_arn
}