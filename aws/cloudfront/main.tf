#tfsec:ignore:aws-cloudfront-enable-waf tfsec:ignore:aws-cloudfront-enable-logging
resource "aws_cloudfront_distribution" "s3_website_cdn" {
  count               = var.s3_website ? 1 : 0
  enabled             = true
  default_root_object = var.index_document

  origin {
    origin_id   = var.s3_origin.origin_id
    domain_name = var.s3_origin.domain_name
    origin_path = var.s3_origin.origin_path
    custom_origin_config {
      http_port              = var.s3_origin.http_port
      https_port             = var.s3_origin.https_port
      origin_protocol_policy = var.s3_origin.protocol_policy
      origin_ssl_protocols   = var.origin_ssl_protocols
    }
  }

  origin {
    origin_id   = var.api_origin.origin_id
    domain_name = var.api_origin.domain_name
    origin_path = var.api_origin.origin_path
    custom_origin_config {
      http_port              = var.api_origin.http_port
      https_port             = var.api_origin.https_port
      origin_protocol_policy = var.api_origin.protocol_policy
      origin_ssl_protocols   = var.origin_ssl_protocols
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
  ordered_cache_behavior {
    target_origin_id         = var.api_origin.origin_id
    path_pattern             = var.api_origin.origin_path
    allowed_methods          = lookup(var.api_origin, "allowed_methods", ["GET", "HEAD"])
    cached_methods           = lookup(var.api_origin, "cached_methods", [])
    viewer_protocol_policy   = "redirect-to-https"
    cache_policy_id          = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac"
    compress                 = true
  }

  dynamic "custom_error_response" {
    for_each = var.custom_errors
    content {
      error_code         = custom_error_response.value.error_code
      response_code      = custom_error_response.value.response_code
      response_page_path = custom_error_response.value.response_page_path
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
    cloudfront_default_certificate = true
  }
  price_class = var.price_class
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.s3_website ? 1 : 0
  bucket = var.s3_bucket_name
  policy = <<EOT
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
      {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "${var.s3_bucket_arn}/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "${aws_cloudfront_distribution.s3_website_cdn[0].arn}"
                }
            }
        },
        {
            "Sid": "AddPublicAcl",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${var.s3_user_arn}"
            },
            "Action": [
                "s3:*Object"
            ],
            "Resource": "${var.s3_bucket_arn}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "public-read"
                }
            }
        }
    ]
}
EOT
}
