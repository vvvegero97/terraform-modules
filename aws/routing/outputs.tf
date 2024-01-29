output "name_servers" {
  value       = aws_route53_zone.primary.name_servers
  description = "NS records of the hosted zone."
}
