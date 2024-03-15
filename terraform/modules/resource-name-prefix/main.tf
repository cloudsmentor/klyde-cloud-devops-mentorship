##########################
#     Naming Config      #
##########################
locals {
  name = "${var.name}-${var.tags["Project"]}-${var.tags["Environment"]}"
}