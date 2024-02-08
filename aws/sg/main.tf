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

resource "aws_security_group_rule" "custom" {
  for_each          = var.custom_ingress_rules
  type              = "ingress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = each.value.protocol
  description       = each.value.description
  cidr_blocks       = lookup(each.value, "cidr_blocks", null)
  security_group_id = module.project_sg.security_group_id
}
