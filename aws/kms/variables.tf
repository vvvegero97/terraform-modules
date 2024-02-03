variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "aws_iam_service_linked_role_autoscaling" {
  description = "Controls if AWS IAM Service linked role Autoscaling should be created."
  type        = bool
  default     = false
}

variable "name" {
  type        = string
  default     = "key"
  description = "KMS Key name."
}
