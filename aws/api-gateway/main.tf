resource "aws_apigatewayv2_api" "this" {
  name          = "${var.deployment_prefix}-api-gw-${var.api_gw_protocol_type}"
  protocol_type = var.api_gw_protocol_type
  # target        = var.api_target
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

  route_key = "${each.value.source_method}${var.api_route}}" # whitespace between??
  target    = "integrations/${aws_apigatewayv2_integration.this[each.key].id}"
}
