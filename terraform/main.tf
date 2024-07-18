provider "aws" {
  region = "us-east-1" # Substitua pela sua região
}

# Role da Lambda
resource "aws_iam_role" "lambda_role" {
  name = "${var.github_repo}_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Anexar a política gerenciada de execução da Lambda
resource "aws_iam_role_policy_attachment" "lambda_execution_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::454362774081:policy/service-role/AWSLambdaBasicExecutionRole-6fa39d0a-3258-4b92-97c6-86e36fd0c777"
}

resource "aws_iam_role_policy_attachment" "vpc_access_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::454362774081:policy/service-role/AWSLambdaVPCAccessExecutionRole-8614bab3-8584-4120-ae3e-46499e139c81"
}

# Função Lambda
resource "aws_lambda_function" "lambda_function" {
  function_name = var.github_repo
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_role.arn
  layers        = var.lambda_layers

  filename         = "${path.module}/lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda.zip")
  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
}

# Permissões para a Lambda (exemplo)
resource "aws_lambda_permission" "allow_execution_from_api_gateway" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
}