output "distribution_url" {
  value       = aws_cloudfront_distribution.s3_website_cdn.*.domain_name
  description = "Distribution public URL."
}

output "hosted_zone_id" {
  value       = aws_cloudfront_distribution.s3_website_cdn.*.hosted_zone_id
  description = "Hosted zone ID for the created CF distribution."
}
