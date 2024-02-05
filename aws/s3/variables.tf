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

variable "public_acl_block" {
  type = map(bool)
  default = {
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
  }
  description = "Public ACL Block switches."
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

variable "put_objects" {
  type = map(object({
    bucket_key   = string
    source       = string
    is_file      = bool
    acl          = optional(string)
    content_type = optional(string)
  }))
  default = {
    # "my_file" = {
    #   is_file = true
    #   bucket_key = "path/to/bucket/target/object"
    #   source     = "path/to/source/my_file"
    # }
    # "my_public_file" = {
    #   is_file = true
    #   bucket_key = "path/to/bucket/target/object"
    #   source     = "path/to/source/my_public_file"
    #   acl        = "public-read"
    # }
    # "my_folder" = {
    #   is_file = false
    #   bucket_key = "path/to/bucket/target/object/my_folder/"
    #   source     = "path/to/source/my_folder/"
    # }
  }
  description = "Map of objects to put in a bucket after creation. Files should be located in put_objects directory."
}
