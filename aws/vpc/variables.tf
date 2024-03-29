variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks."
  type        = bool
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone."
  type        = bool
  default     = false
}

variable "enable_nat_gateway" {
  type        = bool
  default     = false
  description = "Should be true if you want to enable NAT Gateway"
}
