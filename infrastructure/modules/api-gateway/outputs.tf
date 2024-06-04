output "api_gateway_id" {
  value = aws_api_gateway_rest_api.example.id
}

output "resource_id" {
  value = aws_api_gateway_resource.example.id
}

output "api_gateway_body" {
  value = aws_api_gateway_rest_api.example.body
}