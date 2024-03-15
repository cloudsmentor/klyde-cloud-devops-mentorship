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
variable "assume_role_policy" {
  description = "Default policy that grants an entity permission to assume the role, used only if 'trust_policy_json' and 'trust_policy_hcl' are not provided."
  type        = any
  default     = {}
}

variable "path" {
  description = "Path in which to create the role."
  type        = string
  default     = "/"
}

variable "description" {
  description = "The description of the role."
  type        = string
  default     = "Managed by Terraform."
}

variable "policy_arns" {
  description = "A map of policy names to policy ARNs to attach to the IAM role."
  type        = map(string)
}

variable "trust_policy_json" {
  description = "The trust policy for the IAM role as a raw JSON string. If provided, 'trust_policy_hcl' is ignored."
  type        = string
  default     = ""
}

variable "trust_policy_hcl" {
  description = "The trust policy for the IAM role as HCL. Converted to JSON using 'jsonencode'. Ignored if 'trust_policy_json' is provided."
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