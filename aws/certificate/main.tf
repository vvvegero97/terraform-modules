resource "aws_acm_certificate" "this" {
  domain_name               = var.domains[0].domain
  subject_alternative_names = [for item in var.domains : item.domain]

  validation_method = "DNS"
}

data "aws_route53_zone" "selected_zones" {
  for_each = { for item in var.domains : item.domain => item.zone_name }
  name     = each.value
}

resource "aws_route53_record" "validation" {
  for_each = { for idx, val in aws_acm_certificate.this.domain_validation_options : idx => val }

  zone_id = data.aws_route53_zone.selected_zones[each.value.domain_name].zone_id
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  ttl     = 60
  records = [each.value.resource_record_value]
}


resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = aws_route53_record.validation[*].fqdn
}
