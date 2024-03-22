########################
#        tags          #
########################
module "tags" {
  source = "./modules/tags"

  project     = var.project
  client      = var.client
  owner       = var.owner
  environment = var.environment
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}