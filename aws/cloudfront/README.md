# cloudfront

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.34.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.34.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3_website_cdn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | ACM Certificate for alias domain. | `string` | `"none"` | no |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | List of CNAMEs for this CloudFront Distribution. | `list(string)` | `[]` | no |
| <a name="input_api_origin"></a> [api\_origin](#input\_api\_origin) | API Gateway Origin parameters. | <pre>object({<br>    origin_id       = string<br>    origin_path     = string<br>    domain_name     = string<br>    http_port       = number<br>    https_port      = number<br>    protocol_policy = string<br>    allowed_methods = list(string)<br>    cached_methods  = list(string)<br>  })</pre> | `null` | no |
| <a name="input_custom_errors"></a> [custom\_errors](#input\_custom\_errors) | List variable with custom error responces. | <pre>list(object({<br>    error_code         = number<br>    response_code      = number<br>    response_page_path = string<br>  }))</pre> | <pre>[<br>  {<br>    "error_code": 404,<br>    "response_code": 200,<br>    "response_page_path": "index.html"<br>  }<br>]</pre> | no |
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment. | `string` | `"terraform"` | no |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | If set to 'true', enables IPv6 for CloudFront Distributions. | `bool` | `false` | no |
| <a name="input_index_document"></a> [index\_document](#input\_index\_document) | Index document for S3 bucket Website configuration. | `string` | `"index.html"` | no |
| <a name="input_locations"></a> [locations](#input\_locations) | List of locations for whitelist/blacklist. Uses 2-letter country codes. | `list(string)` | `[]` | no |
| <a name="input_origin_ssl_protocols"></a> [origin\_ssl\_protocols](#input\_origin\_ssl\_protocols) | List of origin SSL Protocols (default recommended. | `list(string)` | <pre>[<br>  "TLSv1.2"<br>]</pre> | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | AWS CloudFront PriceClass. | `string` | `"PriceClass_All"` | no |
| <a name="input_restriction_type"></a> [restriction\_type](#input\_restriction\_type) | Restrict distribution of your content by country: none, whitelist, or blacklist. | `string` | `"none"` | no |
| <a name="input_s3_bucket_arn"></a> [s3\_bucket\_arn](#input\_s3\_bucket\_arn) | S3 Bucket ARN. | `string` | `""` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | S3 Bucket Name. | `string` | `""` | no |
| <a name="input_s3_origin"></a> [s3\_origin](#input\_s3\_origin) | S3 Origin parameters. | <pre>object({<br>    origin_id       = string<br>    domain_name     = string<br>    origin_path     = string<br>    http_port       = number<br>    https_port      = number<br>    protocol_policy = string<br>    allowed_methods = list(string)<br>    cached_methods  = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_s3_user_arn"></a> [s3\_user\_arn](#input\_s3\_user\_arn) | S3 user ARN. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_distribution_url"></a> [distribution\_url](#output\_distribution\_url) | Distribution public URL. |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | Hosted zone ID for the created CF distribution. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
