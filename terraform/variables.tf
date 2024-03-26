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
#        CI_CD         #
########################
variable "github_org" {
  description = "Github Orgnization"
  type        = string
  default     = "devsmentor"
}

variable "github_repo" {
  description = "Github Repo"
  type        = string
  default     = "klyde-cloud-devops-mentorship"
}

########################
#        VPC           #
########################
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

########################
#        Subnet        #
########################
variable "public_subnet_cidrs" {
  description = "The CIDR block for the public Subnet."
  type        = list(string)
  default = [
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = "The CIDR block for the private Subnet."
  type        = list(string)
  default = [
    "10.0.7.0/24",
    "10.0.8.0/24",
    "10.0.9.0/24"
  ]
}
