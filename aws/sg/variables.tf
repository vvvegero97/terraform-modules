variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "vpc_id" {
  description = "AWS VPC ID."
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  type        = string
}

variable "type" {
  description = "Type of the security group"
  type        = string
  default     = "terraform"
}

variable "ingress_rules" {
  type        = list(string)
  default     = ["https-443-tcp", "http-80-tcp", "ssh-tcp"]
  description = "List of predefined ingress rules."
}

variable "custom_ingress_rules" {
  type = map(object({
    protocol    = string
    port        = number
    description = string
    cidr_blocks = optional(string)
  }))
  default = {}
}
