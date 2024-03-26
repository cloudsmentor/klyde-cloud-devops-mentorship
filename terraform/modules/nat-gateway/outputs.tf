output "nat_gateway_id" {
  description = "The ID of the NAT Gateway."
  value       = aws_nat_gateway.nat.id
}

output "eip_allocation_id" {
  description = "The Allocation ID of the Elastic IP address for the NAT Gateway."
  value       = var.allocation_id != "" ? var.allocation_id : module.eip[0].eip_address
}

output "eip_address" {
  value       = var.allocation_id != "" ? null : module.eip[0].eip_address
  description = "The public IP address of the Elastic IP."
}