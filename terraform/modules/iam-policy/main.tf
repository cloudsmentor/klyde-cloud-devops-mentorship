##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source  = "../resource-name-prefix"

  name = var.name
  tags = var.tags
}

############################
#       IAM Policy         #
############################
resource "aws_iam_policy" "iam_policy" {
  name        = "${module.resource_name_prefix.resource_name}-policy"
  path        = var.path
  description = var.description

  # Policy document
  policy = var.policy_json != "" ? var.policy_json : jsonencode(var.policy_hcl)
}



