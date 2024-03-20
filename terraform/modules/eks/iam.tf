############################
#        IAM Role          #
############################
module "eks_cluster_iam_role" {
  source = "../iam-role"

  name        = "cluster"
  path        = "/"
  description = "IAM Role for ${local.cluster_name} EKS Cluster"
  policy_arns = var.policy_arns

  trust_policy_hcl = {
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = { 
          Service = "eks.amazonaws.com" 
        },
        Action    = "sts:AssumeRole"
      }
    ]
  }

  tags = var.tags
}

module "eks_node_iam_role" {
  source = "../iam-role"

  name        = "node-group"
  path        = "/"
  description = "IAM Role for ${local.cluster_name} EKS Node"
  policy_arns = var.policy_arns

  trust_policy_hcl = {
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = { 
          Service = "ec2.amazonaws.com" 
        },
        Action    = "sts:AssumeRole"
      }
    ]
  }

  tags = var.tags
}