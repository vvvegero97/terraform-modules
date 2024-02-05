output "cert_arn" {
  value       = aws_acm_certificate.this.arn
  description = "Created certificate ARN."
}
