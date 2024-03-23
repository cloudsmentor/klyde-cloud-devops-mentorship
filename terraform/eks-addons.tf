locals {
    ebs_csi_driver_name = "aws-ebs-csi-driver"
    ebs_csi_driver_version = "v1.28.0-eksbuild.1"
}

############################
#        IAM Role          #
############################
module "eks_ebs_csi_iam_role" {
  source = "./modules/iam-role"

  name        = local.ebs_csi_driver_name
  path        = "/"
  description = "IAM role for ${local.ebs_csi_driver_name} - version: ${local.ebs_csi_driver_name}"
  policy_arns = {
    "AmazonEBSCSIDriverPolicy"             = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  }

  trust_policy_hcl = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${module.eks_cluster.eks_oidc_issuer_url}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${module.eks_cluster.eks_oidc_issuer_url}:aud" = "sts.amazonaws.com"
            "${module.eks_cluster.eks_oidc_issuer_url}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      }
    ]
  }

  tags = module.tags.tags
}
