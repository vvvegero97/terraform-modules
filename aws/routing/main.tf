resource "aws_route53_zone" "primary" {
  name = var.domain

  tags = {
    Terraform = "true"
    Name      = "${var.deployment_prefix}-${var.domain}-root"
    Domain    = var.domain
  }
}

# Create Route53 DNS records from the map variable
resource "aws_route53_record" "custom_records" {
  for_each = var.record_map

  zone_id = aws_route53_zone.primary.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = can(each.value.ttl) && !can(each.value.alias_name) ? each.value.ttl : null
  records = can(each.value.records) && !can(each.value.alias_name) ? each.value.records : null

  dynamic "alias" {
    for_each = can(each.value.alias_name) && !can(each.value.records) && !can(each.value.ttl) ? [1] : [0]

    content {
      name                   = each.value.alias_name
      zone_id                = each.value.alias_zone_id
      evaluate_target_health = each.value.evaluate_target_health
    }
  }
}
