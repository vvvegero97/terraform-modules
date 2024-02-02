module "project_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name   = "${var.deployment_prefix}-${var.type}-sg"
  vpc_id = var.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = var.ingress_rules
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Allow all Outgoing"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

resource "aws_security_group_rule" "docker_remote" {
  count             = var.docker_remote_rule_enabled ? 1 : 0
  type              = "ingress"
  from_port         = 2376
  to_port           = 2376
  protocol          = "tcp"
  description       = "Docker port"
  cidr_blocks       = var.docker_ip_whitelist
  security_group_id = module.project_sg.security_group_id
}

resource "aws_security_group_rule" "docker_swarm" {
  count             = var.docker_swarm_rule_enabled ? 1 : 0
  type              = "ingress"
  from_port         = 2377
  to_port           = 2377
  protocol          = "tcp"
  description       = "Docker swarm join port"
  cidr_blocks       = var.swarm_ip_whitelist
  security_group_id = module.project_sg.security_group_id
}
