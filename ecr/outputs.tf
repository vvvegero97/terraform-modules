output "ecr_repo_url" {
  value       = aws_ecr_repository.template.repository_url
  description = "ECR repository URL"
}

output "ecr_repo_arn" {
  value       = aws_ecr_repository.template.arn
  description = "ECR repository ARN"
}
