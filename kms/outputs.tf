output "kms_deployment_key_arn" {
  description = "KMS Key ARN."
  value       = aws_kms_key.kms_deployment_key.arn
}

output "kms_key_id" {
  description = "KMS Key ID."
  value       = aws_kms_key.kms_deployment_key.key_id
}
