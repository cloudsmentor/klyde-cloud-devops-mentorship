########################
#         ECR          #
########################
output "repository_url" {
  value = aws_ecr_repository.this.repository_url
}

output "repository_name" {
  value = aws_ecr_repository.this.name
}

output "repository_arn" {
  description = "The Amazon Resource Name (ARN) of the created ECR repository."
  value       = aws_ecr_repository.this.arn
}

output "encryption_type" {
  description = "The encryption type of the ECR repository."
  value       = aws_ecr_repository.this.encryption_configuration[0].encryption_type
}

output "kms_key" {
  description = "The KMS key ID used for encrypting the ECR repository."
  value       = aws_ecr_repository.this.encryption_configuration[0].kms_key
}

output "lifecycle_policy" {
  description = "The lifecycle policy applied to the ECR repository."
  value       = length(var.lifecycle_policy_rules) > 0 ? aws_ecr_lifecycle_policy.this[0].policy : "No lifecycle policy applied"
}