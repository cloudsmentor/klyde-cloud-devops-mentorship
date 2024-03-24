##########################
#     Naming Config      #
##########################
module "resource_name_prefix" {
  source = "../resource-name-prefix"

  name = var.name
  tags = var.tags
}

############################
#           EIP            #
############################
resource "aws_eip" "eip" {
  instance = var.instance_id != "" ? var.instance_id : null
  domain   = "vpc"

  tags = merge(
    {
      "Name" = "${module.resource_name_prefix.resource_name}-eip"
    },
    var.tags
  )
}


