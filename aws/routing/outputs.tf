output "name_servers" {
  value       = var.create_hosted_zone ? aws_route53_zone.primary.*.name_servers : data.aws_route53_zone.primary.*.name_servers
  description = "NS records of the hosted zone."
}
