resource "aws_iam_role" "lambda_exec" {
  name = var.lambda_name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_dynamo_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_lambda_function" "lambda_functions" {
  function_name = "tech-demo-${var.lambda_name}"
  filename      = "${path.module}/lambda_function_${var.server_script_name}.zip"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "${var.lambda_name}.lambda_handler"

  source_code_hash = data.archive_file.lambda_function_file.output_base64sha256

  runtime = "python3.11"
}

resource "aws_cloudwatch_log_group" "lambda_log" {
  name              = "/aws/lambda/${aws_lambda_function.lambda_functions.function_name}"
  retention_in_days = 14
}

data "archive_file" "lambda_function_file" {
  type        = "zip"
  source_file = "../server/${var.server_script_name}"
  output_path = "${path.module}/lambda_function_${var.server_script_name}.zip"
}