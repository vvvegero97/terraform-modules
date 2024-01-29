variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
}

# variable "instance_public_key" {
#   type        = string
#   description = "SSH Public key to assign to instances."
# }

variable "kms_key_id" {
  type        = string
  description = "KMS Key ID."
}
