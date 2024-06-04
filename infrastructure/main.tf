# 1. Create S3 Bucket for client side (frontend) files.
module "s3" {
  source = "./modules/s3"

  bucket_name    = var.bucket_name
  website_suffix = var.website_suffix
}
# 2. Upload files to S3 Bucket.
# moved to module

# 3. Create CloudFront Distribution for content delivery.
module "cloudfront" {
  source         = "./modules/cloudfront"
  s3_id          = module.s3.s3_id
  s3_arn         = module.s3.s3_arn
  s3_domain_name = module.s3.s3_domain_name
  s3_name        = module.s3.s3_bucket
}

# 4. Create S3 Bucket policy to allow CloudFront to access files.
# moved to module

# 5. Create DynamoDB (database) to host user data.
module "dynamodb" {
  source     = "./modules/dynamodb"
  table_name = module.s3.s3_bucket
}

# 6. Create Lambda Functions (backend) to process user data.
module "lambda_get" {
  source             = "./modules/lambda"
  server_script_name = "lambda-get.py"
  lambda_name        = "lambda-get"
}

module "lambda_post" {
  source             = "./modules/lambda"
  server_script_name = "lambda-post.py"
  lambda_name        = "lambda-post"
}
# 7. Create API Gateway for API interaction between frontend and backend.

module "api_gateway" {
  source   = "./modules/api-gateway"
  api_name = var.api_gateway_name

}

module "api_gateway_methods_get" {
  source               = "./modules/api-gateway-methods"
  api_gateway_id       = module.api_gateway.api_gateway_id
  resource_id          = module.api_gateway.resource_id
  lambda_arn           = module.lambda_get.lambda_arn
  lambda_function_name = module.lambda_get.lambda_name
  http_method          = "GET"
  region               = var.region
  account_id           = var.account_id
}

module "api_gateway_methods_post" {
  source               = "./modules/api-gateway-methods"
  api_gateway_id       = module.api_gateway.api_gateway_id
  resource_id          = module.api_gateway.resource_id
  lambda_arn           = module.lambda_post.lambda_arn
  lambda_function_name = module.lambda_post.lambda_name
  http_method          = "POST"
  region               = var.region
  account_id           = var.account_id
}

# 8. Deploy API Gateway
module "api_gateway_deply" {
  depends_on       = [module.api_gateway, module.api_gateway_methods_get, module.api_gateway_methods_post]
  source           = "./modules/api-gateway-deploy"
  api_gateway_id   = module.api_gateway.api_gateway_id
  api_gateway_body = module.api_gateway.api_gateway_body
}

# 9. You will need to add api keys to client then update S3 Bucket with aws s3 sync build/ s3://bucket_name