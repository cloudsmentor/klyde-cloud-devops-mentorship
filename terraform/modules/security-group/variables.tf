########################
#    Resource Naming   #
########################
variable "name" {
  description = "The base name of the resources"
  type        = string
}

########################
#       VPC Config     #
########################
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the security group will be created."
}

########################
#    Security Group    #
########################
variable "ingress_rules" {
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    description      = string
    self             = optional(bool)
    security_groups  = optional(list(string))
  }))
  description = "A list of ingress rules."
  default     = []
}

variable "egress_rules" {
  type = list(object({
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    description      = string
    self             = optional(bool)
    security_groups  = optional(list(string))
  }))
  description = "A list of egress rules."
  default     = []
}

########################
#         Tags         #
########################
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}
