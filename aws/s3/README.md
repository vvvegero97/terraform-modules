# s3

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam"></a> [iam](#module\_iam) | ../iam | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_ownership_controls.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_website_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_s3_object.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_s3_bucket_acl"></a> [aws\_s3\_bucket\_acl](#input\_aws\_s3\_bucket\_acl) | S3 bucket ACL. | `string` | `"private"` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | AWS S3 bucket name. | `string` | n/a | yes |
| <a name="input_create_sync_user"></a> [create\_sync\_user](#input\_create\_sync\_user) | If set to true, creates a new IAM user with bucket sync access policy. | `bool` | `false` | no |
| <a name="input_delete_objects_on_bucket_destroy"></a> [delete\_objects\_on\_bucket\_destroy](#input\_delete\_objects\_on\_bucket\_destroy) | If set to 'true', deletes all objects on bucket deletion. | `bool` | `false` | no |
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment. | `string` | `"terraform"` | no |
| <a name="input_error_document"></a> [error\_document](#input\_error\_document) | Error document for S3 bucket Website configuration. | `string` | `"index.html"` | no |
| <a name="input_index_document"></a> [index\_document](#input\_index\_document) | Index document for S3 bucket Website configuration. | `string` | `"index.html"` | no |
| <a name="input_is_website"></a> [is\_website](#input\_is\_website) | If set to true, enables S3 website hosting. | `bool` | `false` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS Key ID to encrypt AWS SSM parameter. | `string` | `""` | no |
| <a name="input_object_ownership"></a> [object\_ownership](#input\_object\_ownership) | S3 Object Ownership. | `string` | `"BucketOwnerPreferred"` | no |
| <a name="input_public_acl_block"></a> [public\_acl\_block](#input\_public\_acl\_block) | Public ACL Block switches. | `map(bool)` | <pre>{<br>  "block_public_acls": false,<br>  "block_public_policy": false,<br>  "ignore_public_acls": false,<br>  "restrict_public_buckets": false<br>}</pre> | no |
| <a name="input_put_objects"></a> [put\_objects](#input\_put\_objects) | Map of objects to put in a bucket after creation. Files should be located in put\_objects directory. | <pre>map(object({<br>    bucket_key   = string<br>    source       = string<br>    is_file      = bool<br>    acl          = optional(string)<br>    content_type = optional(string)<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | AWS S3 bucket ARN. |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | S3 bucket name. |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | S3 regional domain name. |
| <a name="output_created_sync_user_arn"></a> [created\_sync\_user\_arn](#output\_created\_sync\_user\_arn) | Generated sync user ARN. |
| <a name="output_created_sync_user_name"></a> [created\_sync\_user\_name](#output\_created\_sync\_user\_name) | Generated sync user name. |
| <a name="output_website_domain_name"></a> [website\_domain\_name](#output\_website\_domain\_name) | S3 regional website domain name. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
