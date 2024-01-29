module "project_sg" {
  source = "terraform-aws-modules/security-group/aws"

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
  type              = "ingress"
  from_port         = 2376
  to_port           = 2376
  protocol          = "tcp"
  description       = "Docker port"
  cidr_blocks       = var.ip_whitelist
  security_group_id = module.project_sg.security_group_id
}

resource "aws_security_group_rule" "docker_swarm" {
  type              = "ingress"
  from_port         = 2377
  to_port           = 2377
  protocol          = "tcp"
  description       = "Docker swarm jon port"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.project_sg.security_group_id
}
