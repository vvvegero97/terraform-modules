variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "domain" {
  description = "The main Route53 domain."
  type        = string
}

variable "record_map" {
  description = "Map variable with records."
  type = map(object({
    name                   = string
    type                   = string
    ttl                    = optional(string)
    records                = optional(list(string))
    alias_name             = optional(string)
    alias_zone_id          = optional(string)
    evaluate_target_health = optional(bool)
  }))
  default = {
    "example1" = {
      name    = "example1.com"
      type    = "A"
      ttl     = "300"
      records = ["1.2.3.4"]
    }
    "example2" = {
      name                   = "example2.com"
      type                   = "A"
      alias_name             = "example2.alias.com"
      alias_zone_id          = "us-east-1"
      evaluate_target_health = false
    }
  }
}
