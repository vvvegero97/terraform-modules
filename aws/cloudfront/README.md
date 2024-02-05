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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_errors"></a> [custom\_errors](#input\_custom\_errors) | List variable with custom error responces. | <pre>list(object({<br>    error_code         = number<br>    response_code      = number<br>    response_page_path = string<br>  }))</pre> | <pre>[<br>  {<br>    "error_code": 404,<br>    "response_code": 200,<br>    "response_page_path": "index.html"<br>  }<br>]</pre> | no |
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment. | `string` | `"terraform"` | no |
| <a name="input_index_document"></a> [index\_document](#input\_index\_document) | Index document for S3 bucket Website configuration. | `string` | `"index.html"` | no |
| <a name="input_locations"></a> [locations](#input\_locations) | List of locations for whitelist/blacklist. Uses 2-letter country codes. | `list(string)` | `[]` | no |
| <a name="input_origin_ssl_protocols"></a> [origin\_ssl\_protocols](#input\_origin\_ssl\_protocols) | List of origin SSL Protocols (default recommended. | `list(string)` | <pre>[<br>  "TLSv1.2"<br>]</pre> | no |
| <a name="input_origins"></a> [origins](#input\_origins) | List variable with origins. | <pre>list(object({<br>    origin_id       = string<br>    origin_path     = string<br>    domain_name     = string<br>    http_port       = number<br>    https_port      = number<br>    protocol_policy = string<br>  }))</pre> | <pre>[<br>  {<br>    "domain_name": "default.com",<br>    "http_port": 80,<br>    "https_port": 443,<br>    "origin_id": "default",<br>    "origin_path": "/origin/*",<br>    "protocol_policy": "match-viewer"<br>  }<br>]</pre> | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | AWS CloudFront PriceClass. | `string` | `"PriceClass_All"` | no |
| <a name="input_restriction_type"></a> [restriction\_type](#input\_restriction\_type) | Restrict distribution of your content by country: none, whitelist, or blacklist. | `string` | `"none"` | no |
| <a name="input_s3_name"></a> [s3\_name](#input\_s3\_name) | Name of S3 bucket to host from. | `string` | n/a | yes |
| <a name="input_s3_website"></a> [s3\_website](#input\_s3\_website) | Configures distribution for S3-hosted website. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_distribution_url"></a> [distribution\_url](#output\_distribution\_url) | Distribution public URL. |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | Hosted zone ID for the created CF distribution. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
