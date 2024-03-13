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