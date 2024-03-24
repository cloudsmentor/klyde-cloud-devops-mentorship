############################
#        IAM Role          #
############################
module "eks_nodes_iam_role" {
  source = "../iam-role"

  name        = "eks-node-group"
  path        = "/"
  description = "IAM Role for ${var.cluster_name} EKS Node"
  policy_arns = var.iam_role_policy_arns

  trust_policy_hcl = {
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  }

  tags = var.tags
}