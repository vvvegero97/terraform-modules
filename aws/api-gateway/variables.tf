variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "api_target" {
  type        = string
  default     = "http://example.com/{proxy+}"
  description = "API Gateway default target"
}

variable "api_route" {
  type        = string
  default     = "/app/{proxy+}"
  description = "API Route."
}

variable "api_gw_protocol_type" {
  type        = string
  default     = "HTTP"
  description = "Api Gateway Protocol Type."
}

variable "api_gw_stage_name" {
  type        = string
  default     = "prod"
  description = "Api Gateway Stage Name."
}

variable "auto_deploy" {
  type        = bool
  default     = true
  description = "If true, enables auto deploy for stage."
}

variable "methods" {
  description = "List of methods to create integrations for."
  type = map(object({
    source_method    = string
    source_url       = string
    integration_type = string
    connection_type  = string
  }))
  default = {
    "any" = {
      source_method    = "ANY"
      source_url       = "example.com"
      integration_type = "HTTP_PROXY"
      connection_type  = "INTERNET"
    }
  }
}
