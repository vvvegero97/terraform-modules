variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
}

variable "instance_name" {
  type        = string
  description = "Partial name of EC2 instances."
}

variable "ami" {
  type        = string
  description = "AMI for instances"
}

variable "monitoring_enabled" {
  type        = bool
  default     = false
  description = "Set to 'true' to enable detailed monitoring"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to be bound to the instances."
}

variable "subnet_id" {
  type        = string
  description = "VPC public subnet to attach the instances to."
}

variable "disable_api_termination" {
  type        = bool
  default     = false
  description = "If true, enables EC2 Instance Termination Protection"
}

variable "volume_encryption" {
  type        = bool
  default     = false
  description = "If set to true, enables EC2 root volume encryption."
}

variable "volume_type" {
  type        = string
  description = "EC2 volume type."
}

variable "volume_size" {
  type        = number
  description = "EC2 volume size."
}

variable "key_pair_name" {
  type        = string
  description = "Key name of the Key Pair to use for the instance."
}

variable "enable_eip" {
  type        = bool
  default     = false
  description = "If true, assigns an Elastic IP address for the EC2 instance."
}

variable "user_data_base64" {
  type        = string
  default     = "IyEvYmluL2Jhc2gKZWNobyAkVVNFUg=="
  description = "Base64 encoded user data script."
}

variable "instance_type" {
  type        = string
  default     = "t3.medium"
  description = "EC2 instance type."
}
