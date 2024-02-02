# cloudfront

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3_website_cdn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment. | `string` | `"terraform"` | no |
| <a name="input_index_document"></a> [index\_document](#input\_index\_document) | Index document for S3 bucket Website configuration. | `string` | `"index.html"` | no |
| <a name="input_locations"></a> [locations](#input\_locations) | List of locations for whitelist/blacklist. Uses 2-letter country codes. | `list(string)` | `[]` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | AWS CloudFront PriceClass. | `string` | `"PriceClass_All"` | no |
| <a name="input_restriction_type"></a> [restriction\_type](#input\_restriction\_type) | Restrict distribution of your content by country: none, whitelist, or blacklist. | `string` | `"none"` | no |
| <a name="input_s3_domain_name"></a> [s3\_domain\_name](#input\_s3\_domain\_name) | description | `string` | `""` | no |
| <a name="input_s3_name"></a> [s3\_name](#input\_s3\_name) | Name of S3 bucket to host from. | `string` | n/a | yes |
| <a name="input_s3_website"></a> [s3\_website](#input\_s3\_website) | Configures distribution for S3-hosted website. | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
