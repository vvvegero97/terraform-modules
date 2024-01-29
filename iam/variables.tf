variable "deployment_prefix" {
  description = "Prefix of the deployment"
  type        = string
}

variable "ecr_user_name" {
  description = "User name for ECR access"
  type        = string
}

variable "ecr_repository_arns" {
  type        = list(string)
  description = "List of ECR repository ARNs to apply the policy to."
}
