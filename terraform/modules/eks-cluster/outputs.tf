########################
#         EKS          #
########################
output "eks_cluster_id" {
  description = "The ID of the EKS Cluster."
  value       = aws_eks_cluster.cluster.id
}

output "eks_cluster_arn" {
  description = "The ARN of the EKS Cluster."
  value       = aws_eks_cluster.cluster.arn
}

output "eks_cluster_endpoint" {
  description = "The endpoint for your EKS Kubernetes API."
  value       = aws_eks_cluster.cluster.endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "The base64 encoded certificate data required to communicate with your cluster."
  value       = aws_eks_cluster.cluster.certificate_authority[0].data
}

output "eks_cluster_name" {
  description = "The name of the EKS Cluster."
  value       = aws_eks_cluster.cluster.name
}
