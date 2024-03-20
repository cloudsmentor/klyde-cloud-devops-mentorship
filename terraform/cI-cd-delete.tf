# Idealy this should be in its own repo away from this project
locals {
  gh_repo_full_name = "${var.github_org}/${var.github_repo}"
}

############################
#          OIDC            #
############################
# https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/
resource "aws_iam_openid_connect_provider" "github_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
  url             = "https://token.actions.githubusercontent.com"
  tags            = module.tags.tags
}

############################
#        IAM Role          #
############################
module "gh_action_iam_role" {
  source = "./modules/iam-role"

  name        = "gh-action"
  path        = "/"
  description = "IAM role for Repo '${local.gh_repo_full_name}' GitHub Actions to access ECR"
  policy_arns = {
    "gh-action-ecr-access"             = module.gh_action_ecr_role_policy.policy_arn
    "github-action-tf-state-s3-access" = module.gh_action_s3_state_role_policy.policy_arn
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
          },
          StringLike = {
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
module "gh_action_ecr_role_policy" {
  source = "./modules/iam-policy"

  description = "Github Action (${local.gh_repo_full_name}) access to ecr"
  name        = "github-action-ecr-access"

  policy_hcl = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:TagResource",
          "ecr:DescribeRepositories",
          "ecr:ListTagsForResource",
          "ecr:DeleteRepository",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutLifecyclePolicy",
          "ecr:GetLifecyclePolicy",
          "ecr:DeleteLifecyclePolicy",
        ]
        Resource = [
          module.ecr.repository_arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken"
        ]
        Resource = [ "*" ]
      }
    ]
  }

  tags = module.tags.tags
}

module "gh_action_s3_state_role_policy" {
  source = "./modules/iam-policy"

  description = "Github Action (${local.gh_repo_full_name}) access to terraform S3 state file"
  name        = "github-action-tf-state-s3-access"

  policy_hcl = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::terraform-state-s3-pfqdhvmq"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectAcl",
          "s3:PutObject"
        ]
        Resource = [
          "arn:aws:s3:::terraform-state-s3-pfqdhvmq/klyde-cloud-devops-mentorship/terraform.tfstate"
        ]
      }
    ]
  }

  tags = module.tags.tags
}

variable "github_org" {
  description = "Github Orgnization"
  type        = string
  default     = "devsmentor"
}

variable "github_repo" {
  description = "Github Repo"
  type        = string
  default     = "klyde-cloud-devops-mentorship"
}

