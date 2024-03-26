########################
#         EKS          #
########################
output "eks_node_group_id" {
  description = "The ID of the EKS Node Group."
  value       = aws_eks_node_group.node_group.id
}

output "eks_node_group_arn" {
  description = "The ARN of the EKS Node Group."
  value       = aws_eks_node_group.node_group.arn
}

output "eks_node_group_status" {
  description = "The status of the EKS Node Group."
  value       = aws_eks_node_group.node_group.status
}

output "eks_node_group_role_arn" {
  description = "The IAM role ARN associated with the EKS Node Group."
  value       = module.eks_nodes_iam_role.iam_role_arn
}
