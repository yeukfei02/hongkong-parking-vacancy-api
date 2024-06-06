# lambda

# lambda iam role
resource "aws_iam_role" "lambda_iam_role" {
  name = "lambda_func_iam_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

# lambda iam role policy
resource "aws_iam_policy" "lambda_iam_role_policy" {
  name        = "lambda_role_iam_policy"
  path        = "/"
  description = "lambda role iam policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "arn:aws:logs:*:*:*",
        "Effect" : "Allow"
      }
    ]
  })
}

# lambda iam role policy attachment
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_iam_role.name
  policy_arn = aws_iam_policy.lambda_iam_role_policy.arn
}

# zip lambda code
data "archive_file" "zip_lambda_code" {
  type        = "zip"
  source_dir  = "${path.module}/handler/"
  output_path = "${path.module}/python/lambda_code.zip"
}

# zip lambda layer code
data "archive_file" "zip_lambda_layer_code" {
  type        = "zip"
  source_dir  = "${path.module}/handler/lambda_layer/"
  output_path = "${path.module}/python_layer/lambda_layer_code.zip"
}

# lambda layer
resource "aws_lambda_layer_version" "lambda_layer" {
  filename                 = "${path.module}/python_layer/lambda_layer_code.zip"
  layer_name               = "get_parking_vacancy_lambda_layer"
  compatible_runtimes      = ["python3.11"]
  compatible_architectures = ["arm64"]
}

# lambda func
resource "aws_lambda_function" "lambda_func" {
  filename      = "${path.module}/python/lambda_code.zip"
  function_name = "get_parking_vacancy"
  role          = aws_iam_role.lambda_iam_role.arn
  handler       = "${path.module}/handler/get_parking_vacancy.handler"
  runtime       = "python3.11"
  architectures = ["arm64"]
  timeout       = 300
  memory_size   = 1024
  layers        = [aws_lambda_layer_version.lambda_layer.arn]
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
  environment {
    variables = {
      PYTHON_ENV = "prod"
    }
  }
}
