########################
#   Resource Naming    #
########################
module "resource_name_prefix" {
  source = "../resource-name-prefix"

  name = var.name
  tags = var.tags
}

########################
#    Security Group    #
########################
resource "aws_security_group" "this" {
  vpc_id      = var.vpc_id
  name        = "${module.resource_name_prefix.resource_name}-sg"
  description = "Security group for ${module.resource_name_prefix.resource_name}"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
      description      = ingress.value.description
      security_groups  = ingress.value.security_groups
      self             = ingress.value.self
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
      description      = egress.value.description
      security_groups  = egress.value.security_groups
      self             = egress.value.self
    }
  }

  tags = merge(
    {
      "Name" = "${module.resource_name_prefix.resource_name}-sg"
    },
    var.tags
  )
}
