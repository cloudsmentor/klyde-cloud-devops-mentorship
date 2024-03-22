##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source  = "../resource-name-prefix"

  name = var.name
  tags = var.tags
}

########################
#      Nat Gateway     #
########################
module "eip" {
  source = "../eip"
  count = var.allocation_id != "" ? 0 : 1

  name = var.name
  tags = var.tags
}

resource "aws_nat_gateway" "nat" {
  allocation_id = var.allocation_id != "" ? var.allocation_id : module.eip[0].eip_allocation_id
  subnet_id     = var.subnet_id

  tags = merge(
    {
      "Name" = "${module.resource_name_prefix.resource_name}-ngw"
    },
    var.tags
  )
}
