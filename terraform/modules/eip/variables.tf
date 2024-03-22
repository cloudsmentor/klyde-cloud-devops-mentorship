########################
#    Resource Naming   #
########################
variable "name" {
  description = "The base name of the resources"
  type        = string
}

#########################
#        EIP            #
#########################
variable "instance_id" {
  description = "The instance ID to associate with the EIP."
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