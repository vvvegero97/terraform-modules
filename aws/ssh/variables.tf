variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "kms_key_id" {
  type        = string
  description = "KMS Key ID."
}
