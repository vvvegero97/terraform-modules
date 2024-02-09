# iam

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
| [aws_iam_access_key.this_user_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_policy.generated_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecr_access_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.ec2_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.this_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy_attachment.arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_iam_user_policy_attachment.attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) | resource |
| [aws_ssm_parameter.this_user_access_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.this_user_secret_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_ec2_role"></a> [create\_ec2\_role](#input\_create\_ec2\_role) | If set to true, creates a role for EC2 -> ECR access. | `bool` | `false` | no |
| <a name="input_create_user"></a> [create\_user](#input\_create\_user) | If set to true, creates a new IAM user. | `bool` | `false` | no |
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment. | `string` | `"terraform"` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS Key ID to encrypt AWS SSM parameter. | `string` | `""` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | List of policy ARNs to apply to a user. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_policy_map"></a> [policy\_map](#input\_policy\_map) | Map variable with policies | <pre>map(object({<br>    name        = string<br>    description = string<br>    policy      = string<br>  }))</pre> | `{}` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | User name for policy mapping. | `string` | `"default-user"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ec2_role_name"></a> [ec2\_role\_name](#output\_ec2\_role\_name) | Name of the created EC2 role. |
| <a name="output_user_arn"></a> [user\_arn](#output\_user\_arn) | ARN of the created user. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
