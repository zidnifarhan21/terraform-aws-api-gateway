resource "aws_api_gateway_rest_api" "my-app" {
  name        = "api-gw-my-app"
  description = "Proxy to handle request to our private API"

  endpoint_configuration {
    types = ["PRIVATE"]
    vpc_endpoint_ids = [
      aws_vpc_endpoint.my-app.id
    ]
  }
}

# resource "aws_apigatewayv2_stage" "dev" {
#   api_id = aws_apigatewayv2_api.api-gw-example-3.id

#   name        = "dev"
#   auto_deploy = true
# }

# For Private Integration to REST API, use v1
resource "aws_api_gateway_vpc_link" "my-app" {
  name        = "REST API VPC Link"
  description = "Rest API VPC Link to Private Resource"
  target_arns = [aws_lb.my-app.arn]
}

# resource "aws_apigatewayv2_integration" "api-gw-example-3" {
#   api_id = aws_apigatewayv2_api.api-gw-example-3.id

#   integration_uri    = aws_lb_listener.my-app-example-3.arn
#   integration_type   = "HTTP_PROXY"
#   integration_method = "ANY"
#   connection_type    = "VPC_LINK"
#   connection_id      = aws_apigatewayv2_vpc_link.my-app-example-3.id
# }

# resource "aws_apigatewayv2_route" "api-gw-example-3" {
#   api_id = aws_apigatewayv2_api.api-gw-example-3.id

#   route_key = "ANY /{proxy+}"
#   target    = "integrations/${aws_apigatewayv2_integration.api-gw-example-3.id}"
# }
