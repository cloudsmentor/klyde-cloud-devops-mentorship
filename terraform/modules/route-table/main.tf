########################
#   Resource Naming    #
########################
module "resource_name_prefix" {
  source = "../resource-name-prefix"

  name = var.name
  tags = var.tags
}

########################
#    Route Table       #
########################
resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block                = route.value["cidr_block"]
      ipv6_cidr_block           = lookup(route.value, "ipv6_cidr_block", null)
      egress_only_gateway_id    = lookup(route.value, "egress_only_gateway_id", null)
      gateway_id                = lookup(route.value, "gateway_id", null)
      nat_gateway_id            = lookup(route.value, "nat_gateway_id", null)
      network_interface_id      = lookup(route.value, "network_interface_id", null)
      transit_gateway_id        = lookup(route.value, "transit_gateway_id", null)
      vpc_peering_connection_id = lookup(route.value, "vpc_peering_connection_id", null)
    }
  }

  tags = merge(
    {
      "Name" = "${module.resource_name_prefix.resource_name}-rt"
    },
    var.tags
  )
}

resource "aws_route_table_association" "rt_assoc" {
  count = length(var.subnets)

  subnet_id      = var.subnets[count.index]
  route_table_id = aws_route_table.rt.id
}
