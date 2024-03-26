########################
#    Resource Naming   #
########################
variable "name" {
  description = "The name of the resources"
  type        = string
}

########################
#   Internet Gateway   #
########################
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

########################
#         Tags         #
########################
variable "tags" {
  description = "Tags from tags module"
  type        = map(string)
}
