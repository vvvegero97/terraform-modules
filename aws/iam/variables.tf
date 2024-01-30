variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "user_name" {
  description = "User name for ECR access."
  type        = string
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
