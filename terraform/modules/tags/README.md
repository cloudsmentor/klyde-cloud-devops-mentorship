# Terraform Tags Module

This Terraform module provides a standardized set of tags that can be used across all AWS resources to ensure consistent tagging.

## Features

- Provides a standardized set of tags including Project, Client, Owner, and Environment.
- Ensures all resources managed by Terraform have a specific `Terraform` tag.
- Allows additional custom tags.

## Usage

```hcl
module "tags" {
  source = "km-tf-registry.onrender.com/klyde-moradeyo__generic-terraform-modues/tags/aws"
  version = "0.0.1"

  project         = "MyProject"
  client          = "ClientName"
  owner           = "OwnerName"
  environment     = "prod"
  additional_tags = {
    "CostCenter" = "IT-Dept"
  }
}

# Example usage of tags module
resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-tf-test-bucket"
  acl    = "private"
  
  tags = module.tags.tags
}
```

## Inputs

| Name            | Description                                                       | Type           | Default | Required |
| --------------- | ----------------------------------------------------------------- | -------------- | ------- | -------- |
| `project`       | Project name to which the resource is associated                  | `string`       | n/a     | yes      |
| `client`        | Client to which the resource is associated                        | `string`       | n/a     | yes      |
| `owner`         | Owner of the resource                                             | `string`       | n/a     | yes      |
| `environment`   | The environment for this deployment (e.g., dev, prod)             | `string`       | n/a     | yes      |
| `additional_tags` | Any additional tags you want to add to AWS resources             | `map(string)`  | `{}`    | no       |

## Outputs

| Name    | Description                          |
| ------- | ------------------------------------ |
| `tags`  | The standardized set of tags         |

## Constraints

- The `environment` variable can only accept the values "dev" or "prod". Any other values will result in a Terraform error.
