########################
#    Resource Naming   #
########################
variable "name" {
  description = "The base name of the resources"
  type        = string
}

############################
#       IAM Policy         #
############################
variable "path" {
  description = "The path in which to create the policy."
  type        = string
  default     = "/"
}

variable "description" {
  description = "The description of the policy."
  type        = string
}

variable "policy_json" {
  description = "The IAM policy document as a raw JSON string. If provided, 'policy_hcl' is ignored."
  type        = string
  default     = ""
}

variable "policy_hcl" {
  description = "The IAM policy document as HCL. Converted to JSON using 'jsonencode'. Ignored if 'policy_json' is provided."
  type        = any
  default     = {}
}

########################
#      Tags Config     #
########################
variable "tags" {
  description = "Tags to assign"
  type        = map(string)
}