output "iam_role_arn" {
  description = "The ARN of the IAM role."
  value       = aws_iam_role.this.arn
}

output "iam_role_name" {
  description = "The name of the IAM role."
  value       = aws_iam_role.this.name
}
