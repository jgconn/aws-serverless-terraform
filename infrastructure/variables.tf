variable "region" {
  description = "Name of the AWS region"
  type        = string
}

variable "account_id" {
  description = "Account ID of AWS account associated with AWS access key & secret key"
  type        = string
}


variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "website_suffix" {
  description = "Name of the file for website suffix"
  type        = string
}

variable "api_gateway_name" {
  description = "Name of API Gateway"
  type        = string
}