output "distribution_url" {
  value       = aws_cloudfront_distribution.s3_website_cdn[0].domain_name
  description = "Distribution public URL."
}
