#tfsec:ignore:aws-cloudfront-enable-waf tfsec:ignore:aws-cloudfront-enable-logging
resource "aws_cloudfront_distribution" "s3_website_cdn" {
  count               = var.s3_website ? 1 : 0
  enabled             = true
  default_root_object = var.index_document

  dynamic "origin" {
    for_each = var.origins
    content {
      origin_id   = origin.value.origin_id
      domain_name = origin.value.domain_name
      origin_path = origin.value.origin_path
      custom_origin_config {
        http_port              = origin.value.http_port
        https_port             = origin.value.https_port
        origin_protocol_policy = origin.value.protocol_policy
        origin_ssl_protocols   = ["TLSv1"]
      }
    }
  }

  dynamic "custom_error_response" {
    for_each = var.custom_errors
    content {
      error_code         = custom_error_response.value.error_code
      response_code      = custom_error_response.value.response_code
      response_page_path = custom_error_response.value.response_page_path
    }
  }

  default_cache_behavior {
    target_origin_id = var.origins[0].origin_id
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
