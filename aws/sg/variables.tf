variable "deployment_prefix" {
  description = "Prefix of the deployment."
  type        = string
  default     = "terraform"
}

variable "vpc_id" {
  description = "AWS VPC ID."
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  type        = string
}

variable "type" {
  description = "Type of the security group"
  type        = string
  default     = "terraform"
}

variable "ingress_rules" {
  type        = list(string)
  default     = ["https-443-tcp", "http-80-tcp", "ssh-tcp"]
  description = "List of predefined ingress rules."
}

variable "docker_remote_rule_enabled" {
  type        = bool
  default     = false
  description = "If true, enables default docker port for remote docker commands."
}

variable "docker_ip_whitelist" {
  type        = list(string)
  description = "List of IP addresses to access Docker Port."
}

variable "docker_swarm_rule_enabled" {
  type        = bool
  default     = false
  description = "If true, enables default docker-swarm port for joining the swarm."
}

variable "swarm_ip_whitelist" {
  type        = list(string)
  description = "List of IP addresses to join Docker Swarm cluster."
}
