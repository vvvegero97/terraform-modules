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
  count           = length(aws_acm_certificate.this.domain_validation_options)
  zone_id         = data.aws_route53_zone.selected_zones[aws_acm_certificate.this.domain_validation_options[count.index].domain_name].zone_id
  name            = aws_acm_certificate.this.domain_validation_options[count.index].resource_record_name
  type            = aws_acm_certificate.this.domain_validation_options[count.index].resource_record_type
  ttl             = 60
  allow_overwrite = true
  records         = [aws_acm_certificate.this.domain_validation_options[count.index].resource_record_value]
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = aws_route53_record.validation[*].fqdn
}
