output "policy_arn" {
  description = "The ARN of the IAM policy."
  value       = aws_iam_policy.iam_policy.arn
}

output "policy_id" {
  description = "The ID of the IAM policy."
  value       = aws_iam_policy.iam_policy.id
}

output "iam_policy_name" {
  description = "The name of the IAM policy."
  value       = aws_iam_policy.iam_policy.name
}
