# EC2 Instance
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  name                        = "${var.deployment_prefix}-${var.instance_name}"
  ami                         = var.ami != null ? var.ami : data.aws_ami.latest_amazon_linux_2023.id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  monitoring                  = var.monitoring_enabled
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  disable_api_termination     = var.disable_api_termination
  associate_public_ip_address = var.enable_eip ? null : true
  iam_instance_profile        = var.ecr_access_role_name != "none" ? var.ecr_access_role_name : null

  user_data_base64 = var.user_data_base64

  root_block_device = [
    {
      encrypted   = var.volume_encryption
      volume_type = var.volume_type
      volume_size = var.volume_size
    },
  ]

  tags = {
    Terraform = "true"
    Name      = "${var.deployment_prefix}-${var.instance_name}"
  }
}

# Elastic IP
resource "aws_eip" "ip" {
  count    = var.enable_eip ? 1 : 0
  instance = module.ec2_instance.id
  domain   = "vpc"
}

locals {
  eip_public_ip = var.enable_eip ? aws_eip.ip[0].public_ip : null
}

resource "aws_eip_association" "eip_assoc" {
  count         = var.enable_eip ? 1 : 0
  instance_id   = module.ec2_instance.id
  allocation_id = aws_eip.ip[count.index].id
}

# AMI
data "aws_ami" "latest_amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
