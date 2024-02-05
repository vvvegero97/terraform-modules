variable "dns_zone" {
  type        = string
  description = "Route53 Zone containing the Domain name."
}

variable "domain_name" {
  type        = string
  description = "Domain name to issue ACM certificate for."
}
