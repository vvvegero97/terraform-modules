# sg

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.63.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_project_sg"></a> [project\_sg](#module\_project\_sg) | terraform-aws-modules/security-group/aws | 5.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group_rule.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_ingress_rules"></a> [custom\_ingress\_rules](#input\_custom\_ingress\_rules) | n/a | <pre>map(object({<br>    protocol    = string<br>    port        = number<br>    description = string<br>    cidr_blocks = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment. | `string` | `"terraform"` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | List of predefined ingress rules. | `list(string)` | <pre>[<br>  "https-443-tcp",<br>  "http-80-tcp",<br>  "ssh-tcp"<br>]</pre> | no |
| <a name="input_type"></a> [type](#input\_type) | Type of the security group | `string` | `"terraform"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block of the VPC | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | AWS VPC ID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_id"></a> [sg\_id](#output\_sg\_id) | SG ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
