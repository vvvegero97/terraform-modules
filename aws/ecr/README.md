# ecr

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.template_cache_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.template_cache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_ecr_cache_repository"></a> [create\_ecr\_cache\_repository](#input\_create\_ecr\_cache\_repository) | Determines whether to create cache ECR repository or not | `bool` | `false` | no |
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment | `string` | `"terraform"` | no |
| <a name="input_ecr_name"></a> [ecr\_name](#input\_ecr\_name) | ECR name for service | `string` | n/a | yes |
| <a name="input_ecr_user_arn"></a> [ecr\_user\_arn](#input\_ecr\_user\_arn) | User ARN to grant access to. | `string` | `"none"` | no |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE | `string` | `"IMMUTABLE"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN KMS key | `string` | n/a | yes |
| <a name="input_number_of_days_to_keep_cache_images"></a> [number\_of\_days\_to\_keep\_cache\_images](#input\_number\_of\_days\_to\_keep\_cache\_images) | A number of days to keep cache images. | `number` | `14` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_repo_arn"></a> [ecr\_repo\_arn](#output\_ecr\_repo\_arn) | ECR repository ARN |
| <a name="output_ecr_repo_url"></a> [ecr\_repo\_url](#output\_ecr\_repo\_url) | ECR repository URL |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
