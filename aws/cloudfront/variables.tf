variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "index_document" {
  type        = string
  default     = "index.html"
  description = "Index document for S3 bucket Website configuration."
}

variable "price_class" {
  type        = string
  default     = "PriceClass_All"
  description = "AWS CloudFront PriceClass."
}

variable "restriction_type" {
  type        = string
  default     = "none"
  description = "Restrict distribution of your content by country: none, whitelist, or blacklist."
}

variable "locations" {
  type        = list(string)
  default     = []
  description = "List of locations for whitelist/blacklist. Uses 2-letter country codes."
}

variable "custom_errors" {
  description = "List variable with custom error responces."
  type = list(object({
    error_code         = number
    response_code      = number
    response_page_path = string
  }))
  default = [
    {
      error_code         = 404
      response_code      = 200
      response_page_path = "index.html"
    }
  ]
}

variable "s3_origin" {
  type = object({
    origin_id       = string
    domain_name     = string
    origin_path     = string
    http_port       = number
    https_port      = number
    protocol_policy = string
    allowed_methods = list(string)
    cached_methods  = list(string)
  })
  description = "S3 Origin parameters."
}

variable "api_origin" {
  type = object({
    origin_id       = string
    origin_path     = string
    domain_name     = string
    http_port       = number
    https_port      = number
    protocol_policy = string
    allowed_methods = list(string)
    cached_methods  = list(string)
  })
  description = "API Gateway Origin parameters."
}

variable "s3_bucket_arn" {
  type        = string
  default     = ""
  description = "S3 Bucket ARN."
}

variable "s3_bucket_name" {
  type        = string
  default     = ""
  description = "S3 Bucket Name."
}

variable "s3_user_arn" {
  type        = string
  default     = ""
  description = "S3 user ARN."
}

variable "origin_ssl_protocols" {
  type        = list(string)
  default     = ["TLSv1.2"]
  description = "List of origin SSL Protocols (default recommended."
}
