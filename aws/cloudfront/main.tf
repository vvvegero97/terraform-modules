locals {
  s3_origin_id = "${var.s3_name}-origin"
  # s3_domain_name = "${var.s3_name}.s3-website-${var.aws_region}.amazonaws.com"
}

#tfsec:ignore:aws-cloudfront-enable-waf tfsec:ignore:aws-cloudfront-enable-logging
resource "aws_cloudfront_distribution" "s3_website_cdn" {
  count               = var.s3_website ? 1 : 0
  enabled             = true
  default_root_object = var.index_document
  origin {
    origin_id   = local.s3_origin_id
    domain_name = var.s3_domain_name
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1"]
    }
  }
  default_cache_behavior {
    target_origin_id = local.s3_origin_id
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }
  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.restriction_type == "none" ? [] : var.locations
    }
  }
  #tfsec:ignore:aws-cloudfront-use-secure-tls-policy
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  price_class = var.price_class
}
