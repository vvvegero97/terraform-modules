# routing

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.67.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.67.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.alias_records](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.custom_records](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_hosted_zone"></a> [create\_hosted\_zone](#input\_create\_hosted\_zone) | If set to true, creates the hosted zone specified in 'var.domain'. If set to false - gets the existing hosted zone through terraform data. | `bool` | `true` | no |
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment. | `string` | `"terraform"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The main Route53 domain. | `string` | n/a | yes |
| <a name="input_record_map"></a> [record\_map](#input\_record\_map) | Map variable with records. | <pre>map(object({<br>    name                   = string<br>    type                   = optional(string)<br>    ttl                    = optional(string)<br>    records                = optional(list(string))<br>    alias_name             = optional(string)<br>    alias_zone_id          = optional(string)<br>    evaluate_target_health = optional(bool)<br>  }))</pre> | <pre>{<br>  "example1": {<br>    "name": "example1.com",<br>    "records": [<br>      "1.2.3.4"<br>    ],<br>    "ttl": "300",<br>    "type": "A"<br>  },<br>  "example2": {<br>    "alias_name": "example2.alias.com",<br>    "alias_zone_id": "us-east-1",<br>    "evaluate_target_health": false,<br>    "name": "example2.com",<br>    "type": "A"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | NS records of the hosted zone. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
