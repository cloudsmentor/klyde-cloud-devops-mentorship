########################
#    Resource Naming   #
########################
variable "name" {
  description = "The name of the resources"
  type        = string
}

########################
#    Route Table       #
########################
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "routes" {
  description = "A list of maps that defines the routes in the route table."
  type = list(object({
    cidr_block                = string
    ipv6_cidr_block           = optional(string)
    egress_only_gateway_id    = optional(string)
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    network_interface_id      = optional(string)
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
  }))
  default = []
}

variable "subnets" {
  description = "A list of subnet IDs to associate with the route table."
  type        = list(string)
  default     = []
}

########################
#         Tags         #
########################
variable "tags" {
  description = "Tags from tags module"
  type        = map(string)
}
