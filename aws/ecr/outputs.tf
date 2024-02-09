output "ecr_repo_url" {
  value       = aws_ecr_repository.template.repository_url
  description = "ECR repository URL"
}

output "ecr_repo_arn" {
  value       = aws_ecr_repository.template.arn
  description = "ECR repository ARN"
}

output "ecr_policy" {
  value       = data.aws_iam_policy_document.ecr_policy.*.json
  description = "ECR policy document to apply to ECR manually."
}
