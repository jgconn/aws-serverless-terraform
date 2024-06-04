resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = var.api_gateway_id
  triggers = {
    redeployment = sha1(jsonencode(var.api_gateway_body))
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_staging" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = var.api_gateway_id
  stage_name    = "dev"
}

resource "aws_api_gateway_method_settings" "all" {
  rest_api_id = var.api_gateway_id
  stage_name  = aws_api_gateway_stage.api_staging.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled = true
    logging_level   = "ERROR"
  }
}