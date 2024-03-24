########################
#   Resource Naming    #
########################
module "resource_name_prefix" {
  source = "../resource-name-prefix"

  name = var.name
  tags = var.tags
}

########################
#   Internet Gateway   #
########################
resource "aws_internet_gateway" "internet_gw" {
  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = "${module.resource_name_prefix.resource_name}-igw"
    },
    var.tags
  )
}
