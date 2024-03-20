variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "eu-west-2"
}

variable "name" {
  description = "name"
  type        = string
  default     = "flask-api"
}

variable "project" {
  description = "The name of the project"
  type        = string
  default     = "cloud-devops-mentorship"
}

variable "client" {
  description = "The client for the project"
  type        = string
  default     = "public"
}

variable "owner" {
  description = "The owner of the project"
  type        = string
  default     = "Klyde-Moradeyo"
}

variable "environment" {
  description = "The project environment"
  type        = string
  default     = "dev"
}

########################
#        VPC           #
########################
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default = "10.0.0.0/16"
}

########################
#        Subnet        #
########################
variable "subnet_cidrs" {
  description = "The CIDR block for the Subnet."
  type        = list(string)
  default = [
    "10.0.1.0/24", 
    "10.0.2.0/24", 
    "10.0.3.0/24"
  ]
}
