output "bucket_arn" {
  value       = aws_s3_bucket.this.arn
  description = "AWS S3 bucket ARN."
}

output "created_sync_user_name" {
  value       = "${var.deployment_prefix}-${var.bucket_name}-user"
  description = "Generated sync user name."
}

output "created_sync_user_arn" {
  value       = module.iam.user_arn
  description = "Generated sync user ARN."
}

output "bucket_name" {
  value       = aws_s3_bucket.this.id
  description = "S3 bucket name."
}

output "bucket_regional_domain_name" {
  value       = aws_s3_bucket.this.bucket_regional_domain_name
  description = "S3 regional domain name."
}

output "website_domain_name" {
  value       = aws_s3_bucket_website_configuration.this.*.website_domain
  description = "S3 regional website domain name."
}
