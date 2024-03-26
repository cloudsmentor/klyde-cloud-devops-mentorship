locals {
  ebs_csi_driver_name    = "aws-ebs-csi-driver"
  ebs_csi_driver_version = "v1.28.0-eksbuild.1"
  oidc_issuer_str        = replace(module.eks_cluster.eks_oidc_issuer_url, "https://", "")
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  url             = module.eks_cluster.eks_oidc_issuer_url
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  tags            = module.tags.tags
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
    "AmazonEBSCSIDriverPolicy" = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  }

  trust_policy_hcl = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_issuer_str}"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${local.oidc_issuer_str}:aud" = "sts.amazonaws.com"
            "${local.oidc_issuer_str}:sub" = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
          }
        }
      }
    ]
  }

  tags = module.tags.tags
}
