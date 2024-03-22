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
variable "cluster_name" {
  type        = string
  description = "Name of the eks cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of node group subnet IDs for the EKS cluster"
}

variable "desired_size" {
  type        = number
  description = "The desired size of the node group."
}

variable "max_size" {
  type        = number
  description = "The maximum size of the node group."
}

variable "min_size" {
  type        = number
  description = "The minimum size of the node group."
}

variable "ami_type" {
  type        = string
  description = "The type of Amazon Machine Image (AMI) associated with the EKS Node Group."
  default     = "AL2_x86_64"
}

variable "instance_types" {
  type        = list(string)
  description = "The instance types to use for the nodes in the EKS node group."
  default     = ["m5.large"]
}

variable "capacity_type" {
  type        = string
  description = "The capacity type of the EKS node group."
  default     = "ON_DEMAND"
}

variable "iam_role_policy_arns" {
  type        = map(string)
  description = "The list ARNs of the policy to attach to the node group role."
}

variable "remote_access_ssh_key_name" {
  type        = string
  description = "The name of the SSH key that should be used for remote access. If null, remote access is disabled."
  default     = null
}

variable "remote_access_source_security_groups" {
  type        = list(string)
  description = "The list of security group IDs that are allowed to access the nodes. This is required if remote_access_ssh_key_name is specified."
  default     = []
}

variable "node_labels" {
  description = "Kubernetes labels to apply to the nodes in the group."
  type        = map(string)
  default     = {}
}

variable "taints" {
  description = "List of taints to apply to the nodes in the group."
  type        = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default     = []
}

variable "max_unavailable_percentage" {
  description = "Maximum percentage of nodes that can be unavailable during an update."
  type        = number
  default     = null
}

variable "kubernetes_version" {
  description = "Kubernetes version for the nodes in the group."
  type        = string
  default     = null
}

########################
#         Tags         #
########################
variable "tags" {
  description = "Tags from tags module"
  type        = map(string)
}
