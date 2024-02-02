
#tfsec:ignore:aws-s3-ignore-public-acls tfsec:ignore:aws-s3-enable-bucket-encryption tfsec:ignore:aws-s3-block-public-policy tfsec:ignore:aws-s3-block-public-acls tfsec:ignore:aws-s3-no-public-buckets tfsec:ignore:aws-s3-encryption-customer-key tfsec:ignore:aws-s3-enable-bucket-logging tfsec:ignore:aws-s3-enable-versioning tfsec:ignore:aws-s3-specify-public-access-block
resource "aws_s3_bucket" "this" {
  bucket = "${var.deployment_prefix}-${var.bucket_name}"
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.bucket

  index_document {
    suffix = var.index_document
  }

  error_document {
    key = var.error_document
  }

}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "AllowGetObjects"
    Statement = [
      {
        Sid       = "AllowPublic"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.this.arn}/**"
      }
    ]
  })
}

module "iam" {
  source            = "../iam"
  deployment_prefix = var.deployment_prefix
  create_user       = true
  user_name         = "${var.deployment_prefix}-${var.bucket_name}-user"
  kms_key_id        = var.kms_key_id
  policy_map = {
    "allow_objects" = {
      name        = "S3-sync-policy"
      description = "S3 sync policy for ${var.deployment_prefix}-${var.bucket_name}-user"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Sid      = "ListObjectsInBucket"
            Effect   = "Allow"
            Action   = ["s3:ListBucket"]
            Resource = ["${aws_s3_bucket.this.arn}"]
          },
          {
            Sid      = "AllObjectActions"
            Effect   = "Allow"
            Action   = "s3:*Object"
            Resource = ["${aws_s3_bucket.this.arn}/*"]
          }
        ]
      })
    }
  }
}
