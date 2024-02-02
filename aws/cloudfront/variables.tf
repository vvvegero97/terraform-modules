variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "s3_website" {
  type        = bool
  default     = true
  description = "Configures distribution for S3-hosted website."
}

variable "s3_name" {
  type        = string
  description = "Name of S3 bucket to host from."
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

variable "origins" {
  description = "List variable with origins."
  type = list(object({
    origin_id       = string
    origin_path     = string
    domain_name     = string
    http_port       = number
    https_port      = number
    protocol_policy = string
  }))
  default = [
    {
      origin_id       = "default"
      domain_name     = "default.com"
      origin_path     = "/origin/*"
      http_port       = 80
      https_port      = 443
      protocol_policy = "match-viewer"
    }
  ]
}