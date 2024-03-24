########################
#   Resource Naming    #
########################
module "resource_name_prefix" {
  source = "../resource-name-prefix"

  name = var.name
  tags = var.tags
}

########################
#          VPC         #
########################
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    {
      "Name" = "${module.resource_name_prefix.resource_name}-vpc"
    },
    var.tags
  )
}
