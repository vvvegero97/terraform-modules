output "server_public_ip" {
  value       = local.eip_public_ip
  description = "Public IP of the EC2 instance."
}
