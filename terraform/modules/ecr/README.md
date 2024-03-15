# ECR Terraform Module

example usage
```
module "ecr_repository" {
  source               = "../../"
  name                 = "my-application"
  image_tag_mutability = "IMMUTABLE"
  scan_on_push         = true
  lifecycle_policy_rules = [
    {
      description   = "Expire images older than 30 days"
      selection_tag = { key = "env", value = "prod" }
      action_type   = "maximum_age"
      maximum_age   = 30
      maximum_number = 0
    },
    {
      description   = "Retain only the last 5 images"
      selection_tag = { key = "env", value = "dev" }
      action_type   = "maximum_number"
      maximum_age   = 0
      maximum_number = 5
    }
  ]
}
```