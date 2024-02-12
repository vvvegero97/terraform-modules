resource "aws_route53_zone" "primary" {
  count = var.create_hosted_zone ? 1 : 0
  name  = var.domain

  tags = {
    Terraform = "true"
    Name      = "${var.deployment_prefix}-${var.domain}-root"
    Domain    = var.domain
  }
}

data "aws_route53_zone" "primary" {
  count = var.create_hosted_zone ? 0 : 1
  name  = var.domain
}

locals {
  zone_id = var.create_hosted_zone ? aws_route53_zone.primary.*.zone_id : data.aws_route53_zone.primary.*.zone_id
}


# Create Route53 DNS records from the map variable
resource "aws_route53_record" "custom_records" {
  for_each = { for name, record in var.record_map : name => record if lookup(record, "ttl", null) != null }

  zone_id = local.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = lookup(each.value, "ttl", null)
  records = lookup(each.value, "records", null)
}

resource "aws_route53_record" "alias_records" {
  for_each = { for name, record in var.record_map : name => record if lookup(record, "ttl", null) == null }

  zone_id = local.zone_id
  name    = each.value.name
  type    = "A"

  alias {
    name                   = lookup(each.value, "alias_name", null)
    zone_id                = lookup(each.value, "alias_zone_id", null)
    evaluate_target_health = lookup(each.value, "evaluate_target_health", null)
  }
}
