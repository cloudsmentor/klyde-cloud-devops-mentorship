############################
#        IAM Role          #
############################
module "eks_cluster_iam_role" {
  source = "../iam-role"

  name        = "eks-cluster"
  path        = "/"
  description = "IAM Role for ${local.cluster_name} EKS Cluster"
  policy_arns = var.iam_role_policy_arns

  trust_policy_hcl = {
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  }

  tags = var.tags
}