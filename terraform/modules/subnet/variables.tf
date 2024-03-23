########################
#    Resource Naming   #
########################
variable "name" {
  description = "The name of the resources"
  type        = string
}

########################
#       VPC & Subnet   #
########################
variable "vpc_id" {
  description = "The VPC ID where subnets will be created."
  type        = string
}

variable "subnets" {
  description = "A map of availability zones to CIDR blocks for the subnets."
  type        = map(string)
}

variable "map_public_ip_on_launch" {
  description = "Whether resources in the subnet should have public IP addresses automatically assigned."
  type        = bool
  default     = false
}

########################
#         Tags         #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}