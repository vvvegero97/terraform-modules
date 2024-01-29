data "aws_availability_zones" "available" {}

locals {
  cidr_part = trimsuffix(var.cidr, ".0.0")
}

module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  version                = "5.5.1"
  name                   = "${var.deployment_prefix}-VPC"
  cidr                   = "${var.cidr}/16"
  azs                    = data.aws_availability_zones.available.names
  private_subnets        = ["${local.cidr_part}.1.0/24", "${local.cidr_part}.2.0/24", "${local.cidr_part}.3.0/24"]
  public_subnets         = ["${local.cidr_part}.21.0/24", "${local.cidr_part}.22.0/24", "${local.cidr_part}.23.0/24"]
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az
  enable_dns_hostnames   = true
  public_subnet_tags = {
    "Name" = "public-subnet-${var.deployment_prefix}"
  }
  private_subnet_tags = {
    "Name" = "private-subnet-${var.deployment_prefix}"
  }
}
