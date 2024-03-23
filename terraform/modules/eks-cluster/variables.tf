########################
#    Resource Naming   #
########################
variable "name" {
  description = "The name of the resources"
  type        = string
}

########################
#         EKS          #
########################
variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the EKS cluster"
  type        = list(string)
}

variable "endpoint_public_access" {
  description = "Indicates whether the EKS cluster API server endpoint is public"
  type        = bool
}

variable "endpoint_private_access" {
  description = "Indicates whether the EKS cluster API server endpoint is private"
  type        = bool
  default     = false
}

variable "public_access_cidrs" {
  description = "List of CIDR blocks that can access the EKS cluster API server endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "iam_role_policy_arns" {
  type        = map(string)
  description = "The list ARNs of the policy to attach to the node group role."
  # default = {}
}

variable "eks_addons" {
  description = "List of EKS addons to install, with each item being a map containing the addon_name, addon_version, and conflict resolution strategies."
  type = list(object({
    name                      = string
    version                   = string
    service_account_role_arn    = optional(string)
    resolve_conflicts_on_create = optional(string)
    resolve_conflicts_on_update = optional(string)
  }))
  default = []
}


########################
#         Tags         #
########################
variable "tags" {
  description = "Tags from tags module"
  type        = map(string)
}
