
#tfsec:ignore:aws-s3-ignore-public-acls tfsec:ignore:aws-s3-enable-bucket-encryption tfsec:ignore:aws-s3-block-public-policy tfsec:ignore:aws-s3-block-public-acls tfsec:ignore:aws-s3-no-public-buckets tfsec:ignore:aws-s3-encryption-customer-key tfsec:ignore:aws-s3-enable-bucket-logging tfsec:ignore:aws-s3-enable-versioning tfsec:ignore:aws-s3-specify-public-access-block
resource "aws_s3_bucket" "this" {
  bucket = "${var.deployment_prefix}-${var.bucket_name}"
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

#tfsec:ignore:aws-s3-block-public-acls tfsec:ignore:aws-s3-block-public-policy tfsec:ignore:aws-s3-ignore-public-acls tfsec:ignore:aws-s3-no-public-buckets
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.is_public ? true : false
  block_public_policy     = var.is_public ? true : false
  ignore_public_acls      = var.is_public ? true : false
  restrict_public_buckets = var.is_public ? true : false
}

module "iam" {
  source            = "../iam"
  deployment_prefix = var.deployment_prefix
  create_user       = true
  user_name         = "${var.deployment_prefix}-${var.bucket_name}-user"
  kms_key_id        = var.kms_key_id
}
