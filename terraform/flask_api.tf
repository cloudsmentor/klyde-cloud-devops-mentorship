########################
#         ECR          #
########################
module "ecr" {
  source  = "km-tf-registry.onrender.com/klyde-moradeyo__dev-generic-tf-modues/ecr/aws"
  version = "0.0.3"

  name = var.name
  tags = module.tags.tags
}