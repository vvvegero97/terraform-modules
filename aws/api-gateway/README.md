# api-gateway

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.23.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.23.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_apigatewayv2_api.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_api) | resource |
| [aws_apigatewayv2_integration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_integration) | resource |
| [aws_apigatewayv2_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_route) | resource |
| [aws_apigatewayv2_stage.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/apigatewayv2_stage) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_gw_protocol_type"></a> [api\_gw\_protocol\_type](#input\_api\_gw\_protocol\_type) | Api Gateway Protocol Type. | `string` | `"HTTP"` | no |
| <a name="input_api_gw_stage_name"></a> [api\_gw\_stage\_name](#input\_api\_gw\_stage\_name) | Api Gateway Stage Name. | `string` | `"prod"` | no |
| <a name="input_auto_deploy"></a> [auto\_deploy](#input\_auto\_deploy) | If true, enables auto deploy for stage. | `bool` | `true` | no |
| <a name="input_deployment_prefix"></a> [deployment\_prefix](#input\_deployment\_prefix) | Prefix of the deployment. | `string` | `"terraform"` | no |
| <a name="input_methods"></a> [methods](#input\_methods) | List of methods to create integrations for. | <pre>map(object({<br>    source_method    = string<br>    source_url       = string<br>    integration_type = string<br>    connection_type  = string<br>  }))</pre> | <pre>{<br>  "any": {<br>    "connection_type": "INTERNET",<br>    "integration_type": "HTTP_PROXY",<br>    "source_method": "ANY",<br>    "source_url": "example.com"<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_gateway_url"></a> [api\_gateway\_url](#output\_api\_gateway\_url) | API Gateway Invoke URL. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
