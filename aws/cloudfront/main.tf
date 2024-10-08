#tfsec:ignore:aws-cloudfront-enable-waf tfsec:ignore:aws-cloudfront-enable-logging
resource "aws_cloudfront_distribution" "s3_website_cdn" {
  enabled         = true
  aliases         = var.aliases
  is_ipv6_enabled = var.enable_ipv6
  origin {
    origin_id                = var.s3_origin.origin_id
    domain_name              = var.s3_origin.domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.s3.id
  }

  dynamic "origin" {
    for_each = var.api_origin != null ? toset([1]) : toset([])
    content {
      origin_id   = var.api_origin.origin_id
      domain_name = var.api_origin.domain_name
      custom_origin_config {
        http_port              = var.api_origin.http_port
        https_port             = var.api_origin.https_port
        origin_protocol_policy = var.api_origin.protocol_policy
        origin_ssl_protocols   = var.origin_ssl_protocols
      }
    }
  }

  #tfsec:ignore:aws-cloudfront-enforce-https
  default_cache_behavior {
    target_origin_id       = var.s3_origin.origin_id
    allowed_methods        = lookup(var.s3_origin, "allowed_methods", ["GET", "HEAD"])
    cached_methods         = lookup(var.s3_origin, "cached_methods", ["GET", "HEAD"])
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    compress               = false
  }

  #tfsec:ignore:aws-cloudfront-enforce-https
  dynamic "ordered_cache_behavior" {
    for_each = var.api_origin != null ? toset([1]) : toset([])
    content {
      target_origin_id         = var.api_origin.origin_id
      path_pattern             = var.api_origin.origin_path
      allowed_methods          = lookup(var.api_origin, "allowed_methods", ["GET", "HEAD"])
      cached_methods           = lookup(var.api_origin, "cached_methods", [])
      viewer_protocol_policy   = "redirect-to-https"
      cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
      origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac"
      compress                 = true
    }
  }

  dynamic "custom_error_response" {
    for_each = var.custom_errors
    content {
      error_caching_min_ttl = 10
      error_code            = custom_error_response.value.error_code
      response_code         = custom_error_response.value.response_code
      response_page_path    = custom_error_response.value.response_page_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.restriction_type == "none" ? [] : var.locations
    }
  }
  #tfsec:ignore:aws-cloudfront-use-secure-tls-policy
  viewer_certificate {
    cloudfront_default_certificate = var.acm_certificate_arn == "none" ? true : null
    acm_certificate_arn            = var.acm_certificate_arn == "none" ? null : var.acm_certificate_arn
    ssl_support_method             = var.acm_certificate_arn == "none" ? null : "sni-only"
  }
  price_class = var.price_class
}

resource "aws_cloudfront_origin_access_control" "s3" {
  name                              = "${var.s3_origin.origin_id}-OAC"
  description                       = "Origin Access Control for S3"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

locals {
  user_name = trim(element(split("/", var.s3_user_arn), 1), "\"]")
}

module "iam" {
  source            = "../iam"
  deployment_prefix = var.deployment_prefix
  create_user       = false
  user_name         = local.user_name
  policy_map = {
    "allow_objects" = {
      name        = "${aws_cloudfront_distribution.s3_website_cdn.id}-invalidation-policy"
      description = "CloudFront invalidation policy for Distribution ${aws_cloudfront_distribution.s3_website_cdn.id}"
      policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
          {
            Sid    = "CloudFrontInvalidation",
            Effect = "Allow",
            Action = [
              "cloudfront:ListInvalidations",
              "cloudfront:CreateInvalidation"
            ],
            Resource = aws_cloudfront_distribution.s3_website_cdn.arn
          }
        ]
      })
    }
  }
}
