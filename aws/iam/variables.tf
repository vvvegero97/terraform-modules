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

variable "create_ec2_role" {
  type        = bool
  default     = false
  description = "If set to true, creates a role for EC2 -> ECR access."
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

variable "policy_arns" {
  type        = list(string)
  default     = [""]
  description = "List of policy ARNs to apply to a user."
}

variable "kms_key_id" {
  type        = string
  default     = ""
  description = "KMS Key ID to encrypt AWS SSM parameter."
}
