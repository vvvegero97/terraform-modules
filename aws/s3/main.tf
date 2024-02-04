
#tfsec:ignore:aws-s3-ignore-public-acls tfsec:ignore:aws-s3-enable-bucket-encryption tfsec:ignore:aws-s3-block-public-policy tfsec:ignore:aws-s3-block-public-acls tfsec:ignore:aws-s3-no-public-buckets tfsec:ignore:aws-s3-encryption-customer-key tfsec:ignore:aws-s3-enable-bucket-logging tfsec:ignore:aws-s3-enable-versioning tfsec:ignore:aws-s3-specify-public-access-block
resource "aws_s3_bucket" "this" {
  bucket        = "${var.deployment_prefix}-${var.bucket_name}"
  force_destroy = var.delete_objects_on_bucket_destroy
}

resource "aws_s3_object" "this" {
  for_each = var.put_objects
  bucket   = aws_s3_bucket.this.id
  key      = each.value.bucket_key
  source   = "put_objects/${each.value.source}"
  acl      = lookup(each.value, "acl", "private")
  etag     = each.value.is_file ? filemd5("put_objects/${each.value.source}") : null
}


resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.this]
  bucket     = aws_s3_bucket.this.id
  acl        = var.aws_s3_bucket_acl
}

#tfsec:ignore:aws-s3-block-public-acls tfsec:ignore:aws-s3-block-public-policy tfsec:ignore:aws-s3-ignore-public-acls tfsec:ignore:aws-s3-no-public-buckets
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.is_public ? false : true
  block_public_policy     = var.is_public ? false : true
  ignore_public_acls      = var.is_public ? false : true
  restrict_public_buckets = var.is_public ? false : true
}

module "iam" {
  source            = "../iam"
  deployment_prefix = var.deployment_prefix
  create_user       = true
  user_name         = "${var.deployment_prefix}-${var.bucket_name}-user"
  kms_key_id        = var.kms_key_id
  policy_map = {
    "allow_objects" = {
      name        = "${var.deployment_prefix}-S3-sync-policy"
      description = "S3 sync policy for ${aws_s3_bucket.this.id}"
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

resource "aws_s3_bucket_website_configuration" "this" {
  count  = var.is_website ? 1 : 0
  bucket = aws_s3_bucket.this.bucket

  index_document {
    suffix = var.index_document
  }
  error_document {
    key = var.error_document
  }
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.is_website ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = 2012 - 10 - 17
    Statement = [
      {
        Sid       = "AllowPublic"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = ["${aws_s3_bucket.this.arn}/**"]
      }
    ]
  })
}
