########################
#        tags          #
########################
module "tags" {
  source  = "km-tf-registry.onrender.com/klyde-moradeyo__dev-generic-tf-modues/tags/aws"
  version = "0.0.1"

  project     = "flask-api"
  client      = "Public"
  owner       = "Klyde-Moradeyo"
  environment = "Dev"
}