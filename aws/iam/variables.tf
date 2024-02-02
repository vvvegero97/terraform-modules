variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "create_user" {
  type        = bool
  default     = false
  description = "If set to true, creates a new IAM user."
}

variable "user_name" {
  description = "User name for policy mapping."
  type        = string
  default     = "default-user"
}

variable "policy_map" {
  description = "Map variable with policies"
  type = map(object({
    name        = string
    description = string
    policy      = string
  }))
  default = {}
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = "KMS Key ID to encrypt AWS SSM parameter."
}
