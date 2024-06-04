output "stage_api_url" {
  value = module.api_gateway_deply.stage_api_url
}

output "cloudfront_url" {
  value = module.cloudfront.cloudfront_url
}