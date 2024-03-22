output "eip_address" {
  value       = aws_eip.eip.public_ip
  description = "The public IP address of the Elastic IP."
}

output "eip_allocation_id" {
  value       = aws_eip.eip.id
  description = "The allocation ID of the Elastic IP."
}

output "associated_instance_id" {
  value       = aws_eip.eip.instance
  description = "The ID of the instance the Elastic IP is associated with, if any."
}


