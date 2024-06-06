terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.22.0"
    }
  }
  required_version = "1.8.5"
}

# lambda
module "lambda" {
  source = "./modules/lambda_func"
}

# apigateway
module "api" {
  source               = "./modules/apigateway"
  lambda_invoke_arn    = module.lambda.lambda_invoke_arn
  lambda_function_name = module.lambda.lambda_function_name
}
