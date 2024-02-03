variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "bucket_name" {
  type        = string
  description = "AWS S3 bucket name."
}

variable "create_sync_user" {
  type        = bool
  default     = false
  description = "If set to true, creates a new IAM user with bucket sync access policy."
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = "KMS Key ID to encrypt AWS SSM parameter."
}

variable "index_document" {
  type        = string
  default     = "index.html"
  description = "Index document for S3 bucket Website configuration."
}

variable "error_document" {
  type        = string
  default     = "index.html"
  description = "Error document for S3 bucket Website configuration."
}

variable "is_public" {
  type        = bool
  default     = false
  description = "If set to true, makes a bucket publicly accessible."
}

variable "is_website" {
  type        = bool
  default     = false
  description = "If set to true, enables S3 website hosting."
}

variable "object_ownership" {
  type        = string
  default     = "BucketOwnerPreferred"
  description = "S3 Object Ownership."
}

variable "aws_s3_bucket_acl" {
  type        = string
  default     = "private"
  description = "S3 bucket ACL."
}

variable "delete_objects_on_bucket_destroy" {
  type        = bool
  default     = false
  description = "If set to 'true', deletes all objects on bucket deletion."
}
