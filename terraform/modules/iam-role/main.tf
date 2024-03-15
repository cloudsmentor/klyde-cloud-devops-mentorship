##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source  = "../resource-name-prefix"

  name = var.name
  tags = var.tags
}

############################
#        IAM Role          #
############################
locals {
  // Determine the assume_role_policy to use
  computed_assume_role_policy = var.trust_policy_json != "" ? var.trust_policy_json : (
    length(keys(var.trust_policy_hcl)) > 0 ? jsonencode(var.trust_policy_hcl) : jsonencode(var.assume_role_policy)
  )
}

resource "aws_iam_role" "this" {
  name               = "${module.resource_name_prefix.resource_name}-role"
  path               = var.path
  description        = var.description
  assume_role_policy = local.computed_assume_role_policy  
  tags               = var.tags
}

resource "aws_iam_policy_attachment" "this" {
  for_each   = var.policy_arns

  name       = "${each.key}-${module.resource_name_prefix.resource_name}-policy"
  roles      = [aws_iam_role.this.name]
  policy_arn = each.value
}

