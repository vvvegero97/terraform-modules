variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "kms_key_id" {
  type        = string
  description = "KMS Key ID."
}

variable "ssh_key_name" {
  type        = string
  default     = "example"
  description = "Main part of the SSH key name."
}
