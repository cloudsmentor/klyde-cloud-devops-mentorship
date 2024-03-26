########################
#       Outputs        #
########################
output "name" {
  description = "Generated name from local configuration."
  value       = module.resource_name_prefix.resource_name
}

########################
#   Internet Gateway   #
########################
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway."
  value       = aws_internet_gateway.internet_gw.id
}
