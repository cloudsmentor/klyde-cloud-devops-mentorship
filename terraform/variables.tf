variable "aws_region" {
  description = "aws region"
  type        = string
  default     = "eu-west-2"
}

variable "name" {
  description = "name"
  type        = string
  default     = "test-flask-api"
}

variable "project" {
  description = "The name of the project"
  type        = string
  default     = "flask-api"
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
