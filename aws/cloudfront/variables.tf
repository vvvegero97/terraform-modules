variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "s3_domain_name" {
  type        = string
  default     = ""
  description = "description"
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

variable "custom_errors_map" {
  description = "Map variable with custom error responces."
  type = map(object({
    error_code         = number
    response_code      = number
    response_page_path = string
  }))
  default = {
    "default" = {
      error_code         = 404
      response_code      = 200
      response_page_path = "index.html"
    }
  }
}
