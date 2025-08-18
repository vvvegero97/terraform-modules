output "server_public_ip" {
  value       = local.eip_public_ip
  description = "Public IP of the EC2 instance."
}

output "server_public_dns" {
  value       = var.enable_eip ? aws_eip.ip[0].public_dns : module.ec2_instance.public_dns
  description = "Public DNS of the EC2 instance."
}
