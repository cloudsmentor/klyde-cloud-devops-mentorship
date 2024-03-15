########################
#        tags          #
########################
module "tags" {
  source  = "./modules/tags"

  project     = "flask-api"
  client      = "public"
  owner       = "Klyde-Moradeyo"
  environment = "dev"
}