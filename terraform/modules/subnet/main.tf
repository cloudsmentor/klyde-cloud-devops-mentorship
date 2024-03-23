##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source  = "../resource-name-prefix"

  name = var.name
  tags = var.tags
}

##########################
#         Subnet         #
##########################
resource "aws_subnet" "subnet" {
  for_each = var.subnets

  vpc_id                  = var.vpc_id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    var.tags,
    { "Name" = "${module.resource_name_prefix.resource_name}-${each.key}" }
  )
}
