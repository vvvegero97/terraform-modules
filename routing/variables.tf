variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
}

variable "domain" {
  description = "The main Route53 domain."
  type        = string
}

# Map variable with records
variable "record_map" {
  type = map(object({
    name    = string
    type    = string
    ttl     = string
    records = list(string)
  }))
  default = {}
}
