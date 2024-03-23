output "name" {
  description = "Generated name from local configuration."
  value       = module.resource_name_prefix.resource_name
}

output "subnet_ids" {
  description = "List of Subnet IDs."
  value       = [for subnet in aws_subnet.subnet : subnet.id]
}

output "subnet_arns" {
  description = "List of Subnet ARNs."
  value       = [for subnet in aws_subnet.subnet : subnet.arn]
}

output "subnet_azs" {
  description = "List of Availability Zones for the subnets."
  value       = [for subnet in aws_subnet.subnet : subnet.availability_zone]
}