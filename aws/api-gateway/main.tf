resource "aws_apigatewayv2_api" "this" {
  name          = "${var.deployment_prefix}-api-gw-${var.api_gw_protocol_type}"
  protocol_type = var.api_gw_protocol_type
  dynamic "cors_configuration" {
    for_each = var.cors_rules
    content {
      allow_credentials = cors_configuration.value.allow_credentials
      allow_headers     = cors_configuration.value.allow_headers
      allow_methods     = cors_configuration.value.allow_methods
      allow_origins     = cors_configuration.value.allow_origins
      expose_headers    = cors_configuration.value.expose_headers
      max_age           = cors_configuration.value.max_age
    }
  }
}

#tfsec:ignore:aws-api-gateway-enable-access-logging
resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = var.api_gw_stage_name
  auto_deploy = var.auto_deploy
}

resource "aws_apigatewayv2_integration" "this" {
  for_each = var.methods
  api_id   = aws_apigatewayv2_api.this.id

  integration_type   = each.value.integration_type
  integration_uri    = each.value.source_url
  integration_method = each.value.source_method
  connection_type    = each.value.connection_type
}

resource "aws_apigatewayv2_route" "this" {
  for_each = var.methods
  api_id   = aws_apigatewayv2_api.this.id

  route_key = "${each.value.source_method} ${each.value.api_route}"
  target    = "integrations/${aws_apigatewayv2_integration.this[each.key].id}"
}
