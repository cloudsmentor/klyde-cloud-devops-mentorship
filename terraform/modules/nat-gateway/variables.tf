########################
#    Resource Naming   #
########################
variable "name" {
  description = "The base name of the resources"
  type        = string
}

############################
#        IAM Role          #
############################
variable "subnet_id" {
  description = "The Subnet ID where the NAT Gateway will be deployed."
  type        = string
}

variable "allocation_id" {
  description = "The Allocation ID of the Elastic IP address for the NAT Gateway."
  type        = string
  default     = ""
}

########################
#      Tags Config     #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}