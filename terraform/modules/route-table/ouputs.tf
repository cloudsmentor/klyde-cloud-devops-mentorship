########################
#       Outputs        #
########################
output "name" {
  description = "Generated name from local configuration."
  value       = module.resource_name_prefix.resource_name
}

########################
#    Route Table       #
########################
output "route_table_id" {
  description = "The ID of the route table."
  value       = aws_route_table.rt.id
}
