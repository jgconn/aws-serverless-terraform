variable "api_gateway_id" {
  description = "The ID of the API Gateway resource"
  type        = string
}

variable "resource_id" {
  description = "The ID of the API Gateway resource representing the base path"
  type        = string
}

variable "lambda_arn" {
  description = "ARN of Lambda function"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of Lambda function"
  type        = string
}

variable "http_method" {
  description = "HTTP method"
  type        = string
}

variable "region" {
  description = "Name of AWS region"
  type        = string
}

variable "account_id" {
  description = "Account ID of AWS account associated with AWS access key & secret key"
  type        = string
}