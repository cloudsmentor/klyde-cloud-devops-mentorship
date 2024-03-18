locals {
    gh_repo_full_name = "${var.github_org}/${var.github_repo}"
}

############################
#          OIDC            #
############################
# https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/
resource "aws_iam_openid_connect_provider" "github_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["1b511abead59c6ce207077c0bf0e0043b1382612"]
  url             = "https://token.actions.githubusercontent.com"
  tags = module.tags.tags
}

############################
#        IAM Role          #
############################
module "gh_action_iam_role" {
  source       = "./modules/iam-role"

  name         = "gh-action"
  path         = "/"
  description  = "IAM role for Repo '${local.gh_repo_full_name}' GitHub Actions to access ECR"
  policy_arns = {
    "gh-action-ecr-access" = module.gh_action_role_policy.policy_arn
  }

  trust_policy_hcl = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github_oidc.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com",
            "token.actions.githubusercontent.com:sub" = "repo:${local.gh_repo_full_name}:*"
          }
        }
      }
    ]
  }

  tags = module.tags.tags
}

############################
#       IAM Policy         #
############################
module "gh_action_role_policy" {
  source  = "./modules/iam-policy"

  description = "Github Access to ${local.gh_repo_full_name}"
  name = "github-action-ecr-access"

  policy_hcl = {
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        # "ecr:GetDownloadUrlForLayer",
        # "ecr:BatchGetImage",
        # "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage"
        # "ecr:InitiateLayerUpload",
        # "ecr:UploadLayerPart",
        # "ecr:CompleteLayerUpload"
      ]
      Resource = [ module.ecr.repository_arn ]
    }]
  }
  
  tags = module.tags.tags
}
