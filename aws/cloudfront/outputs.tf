output "distribution_url" {
  value       = aws_cloudfront_distribution.s3_website_cdn.domain_name
  description = "Distribution public URL."
}

output "hosted_zone_id" {
  value       = aws_cloudfront_distribution.s3_website_cdn.hosted_zone_id
  description = "Hosted zone ID for the created CF distribution."
}

locals {
  user_arn_prefix = split("/", var.s3_user_arn)[0]
  user_name       = split("/", var.s3_user_arn)[1]
}

output "s3_bucket_policy_manual" {
  description = "S3 bucket policy to manually apply to the bucket Permission settings after creation."
  value = jsonencode({
    Version = "2008-10-17",
    Id      = "PolicyForCloudFrontPrivateContent",
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipal",
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action   = "s3:GetObject",
        Resource = "${var.s3_bucket_arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.s3_website_cdn.arn
          }
        }
      },
      {
        Sid    = "AddPublicReadCannedAcl",
        Effect = "Allow",
        Principal = {
          AWS = "${local.user_arn_prefix}/${local.user_name}"
        },
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        Resource = "${var.s3_bucket_arn}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "public-read"
          }
        }
      }
    ]
  })
}
