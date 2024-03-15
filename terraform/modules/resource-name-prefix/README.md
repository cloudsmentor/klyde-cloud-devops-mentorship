# Resource Name Prefix Terraform Module

This Terraform module provides functionalities to manage the naming configuration of resources in AWS. It combines the given base name with the provided tags (specifically `Project` and `Environment`) to generate a consistent naming prefix.

## Prerequisites

- **Terraform Tags Module**: Before using the `load-balancer` module, you must integrate the [Terraform Tags Module](../helpers/tags) to ensure consistent tagging across AWS resources. Refer to its documentation to understand its setup and usage.

## Features

- Automated resource naming prefix generation based on base name, project, and environment tags.
- Ensures consistent resource naming conventions across AWS resources.
- Provides output for the generated resource name prefix for easy referencing.

## Usage

```hcl
module "resource_name_prefix" {
  source  = "git@github.com:Klyde-Moradeyo/modules.git//modules/helpers/tags?ref=TF/helpers/resource-name-prefix/vALPHA_0.0.2"
  name    = "MyResource"
  tags    = module.tags.tags
}

# Referencing outputs from the module
output "resource_name_output" {
  value = module.resource_name_prefix.resource_name
}
```
## Inputs

| Name  | Description                           | Type        | Default | Required |
|-------|---------------------------------------|-------------|---------|----------|
| `name`| The base name of the resources        | `string`    | n/a     | yes      |
| `tags`| Tags to assign, must include `Project` and `Environment` keys | `map(string)` | n/a  | yes      |

## Outputs

| Name            | Description               |
|-----------------|---------------------------|
| `resource_name` | Generated resource name prefix |
