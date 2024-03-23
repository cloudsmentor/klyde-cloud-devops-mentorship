########################
#       Outputs        #
########################
output "name" {
  description = "Generated name from local configuration."
  value       = module.resource_name_prefix.resource_name
}

output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC"
}
