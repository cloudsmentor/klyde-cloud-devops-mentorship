# Subnet Terraform Module

This Terraform module manages the creation of AWS Subnets. It's designed to offer flexible configuration options and takes advantage of the automated naming based on project and environment tags.

## Prerequisites

- **Terraform Naming Module**: Before using the `subnet` module, ensure that you have the necessary Terraform Naming Module integrated. This module ensures consistent resource naming based on project and environment tags.

## Features

- Automated naming based on project and environment tags.
- Support for a variable number of subnets based on available Availability Zones.
- Outputs Subnet IDs, ARNs, and Availability Zones.

## Usage

```hcl
module "tags" {
  source          = "git@github.com:Klyde-Moradeyo/modules.git//modules/helpers/tags?ref=TF/helpers/tags/vALPHA_0.0.1"

  project         = "MyProject"
  client          = "ClientName"
  owner           = "OwnerName"
  environment     = "prod"
  additional_tags = {
    "CostCenter" = "IT-Dept"
  }
}

module "subnet" {
  source               = "git@github.com:Klyde-Moradeyo/modules.git//modules/subnet?ref=subnet/vALPHA_0.0.1"
  name                 = "MyResourceName"
  vpc_id               = "vpc-01234567"
  subnet_cidr_blocks   = ["10.0.1.0/24", "10.0.2.0/24"]

  tags                 = module.tags.tags
}

# Referencing outputs from the module
output "subnet_ids" {
  value = module.subnet.subnet_ids
}
```

## Inputs

| Name                 | Description                                       | Type          | Default | Required |
|----------------------|---------------------------------------------------|---------------|---------|----------|
| `name`               | The name of the resources.                        | `string`      | n/a     | yes      |
| `vpc_id`             | The VPC ID where subnets will be created.         | `string`      | n/a     | yes      |
| `subnet_cidr_blocks` | List of CIDR blocks for subnets.                  | `list(string)`| n/a     | yes      |
| `tags`               | Tags to assign, including project and environment.| `map(string)` | n/a     | yes      |

## Outputs

| Name                 | Description                             |
|----------------------|-----------------------------------------|
| `name`               | Generated name from local configuration |
| `subnet_ids`         | List of Subnet IDs                      |
| `subnet_arns`        | List of Subnet ARNs                     |
| `availability_zones` | List of available Availability Zones    |
