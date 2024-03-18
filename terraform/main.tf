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
