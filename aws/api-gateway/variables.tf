variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
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
    api_route        = string
  }))
  default = {
    "any" = {
      source_method    = "ANY"
      source_url       = "example.com"
      integration_type = "HTTP_PROXY"
      connection_type  = "INTERNET"
      api_route        = "/{proxy+}"
    }
  }
}

variable "cors_rules" {
  description = "List of methods to create integrations for."
  type = map(object({
    allow_credentials = optional(bool)
    allow_headers     = list(string)
    allow_methods     = list(string)
    allow_origins     = list(string)
    expose_headers    = list(string)
    max_age           = number
  }))
  default = {}
}

variable "description" {
  type        = string
  default     = ""
  description = "Description of the API-Gateway to create."
}
