output "ec2_role_name" {
  value       = var.create_ec2_role ? aws_iam_role.ecr_access_role[0].name : null
  description = "Name of the created EC2 role."
}

output "user_arn" {
  value       = var.create_user ? aws_iam_user.this_user.*.arn : null
  description = "ARN of the created user."
}
