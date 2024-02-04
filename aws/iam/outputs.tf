output "ec2_role_name" {
  value       = var.create_ec2_role ? aws_iam_role.ecr_access_role[0].name : null
  description = "Name of the created EC2 role."
}
