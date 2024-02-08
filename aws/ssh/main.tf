resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.deployment_prefix}-${var.ssh_key_name}-ssh-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "aws_ssm_parameter" "key_pair_ssh_public_key" {
  name        = "/${var.deployment_prefix}/${var.ssh_key_name}/ssh_key_pair/public_key"
  description = "SSH public key in order to connect to Docker Swarm nodes for deployment: ${var.deployment_prefix}"
  tier        = "Standard"
  type        = "SecureString"
  key_id      = var.kms_key_id
  value       = tls_private_key.ssh_key.public_key_openssh
}

resource "aws_ssm_parameter" "key_pair_ssh_private_key" {
  name        = "/${var.deployment_prefix}/${var.ssh_key_name}/ssh_key_pair/private_key"
  description = "SSH private key in order to connect to Docker Swarm nodes for deployment: ${var.deployment_prefix}"
  tier        = "Standard"
  type        = "SecureString"
  key_id      = var.kms_key_id
  value       = tls_private_key.ssh_key.private_key_pem
}
