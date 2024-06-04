output "lambda_name" {
  value = aws_lambda_function.lambda_functions.function_name
}

output "lambda_arn" {
  value = aws_lambda_function.lambda_functions.invoke_arn
}