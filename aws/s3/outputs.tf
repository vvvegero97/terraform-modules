output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "AWS S3 bucket ARN."
}

output "created_sync_user_name" {
  value       = "${var.deployment_prefix}-${var.bucket_name}-user"
  description = "Generated sync user name."
}

output "bucket_name" {
  value       = aws_s3_bucket.this.id
  description = "S3 bucket name."
}
