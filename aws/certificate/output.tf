output "cert_arn" {
  value       = aws_acm_certificate_validation.this.certificate_arn
  description = "Created certificate ARN."
}
