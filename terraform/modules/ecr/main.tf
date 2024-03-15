########################
#   Resource Naming    #
########################
module "resource_name_prefix" {
  source  = "../resource-name-prefix"

  name = var.name
  tags   = var.tags
}

########################
#         ECR          #
########################
resource "aws_ecr_repository" "this" {
  name                 = "${module.resource_name_prefix.resource_name}-ecr"
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  encryption_configuration {
    encryption_type = var.encryption_type
    kms_key         = var.kms_key_id
  }

  tags   = var.tags
}

resource "aws_ecr_lifecycle_policy" "this" {
  count      = length(var.lifecycle_policy_rules) > 0 ? 1 : 0
  repository = aws_ecr_repository.this.name

  policy = jsonencode({
    rules = [for rule in var.lifecycle_policy_rules : {
      rulePriority = rule.priority
      description  = rule.description
      selection = {
        tagStatus = "tagged"
        tagPrefixList = [for k, v in rule.selection_tag : v]
        countType      = rule.action_type == "maximum_number" ? "imageCountMoreThan" : "sinceImagePushed"
        countNumber    = rule.action_type == "maximum_number" ? rule.maximum_number : rule.maximum_age
      }
      action = {
        type = "expire"
      }
    }]
  })
}
