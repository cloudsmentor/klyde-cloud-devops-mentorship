########################
#         ECR          #
########################
module "ecr" {
  source  = "./modules/ecr"

  name = var.name
  tags = module.tags.tags
}