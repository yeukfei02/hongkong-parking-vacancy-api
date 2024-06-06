variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "lambda_invoke_arn" {
  type = string
}

variable "lambda_function_name" {
  type = string
}
