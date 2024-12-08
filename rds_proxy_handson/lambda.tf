module "lambda_function" {
  source = "../modules/lambda_function"

  function_name    = local.prefix
  role_arn         = module.lambda_role.iam_role_arn
  runtime          = "python3.10"
  handler          = "index.lambda_handler"
  timeout          = 300
  source_file      = "lambda/lambda_proxy_access"
  lambda_layer_arn = [module.lambda_layer.layer_arn]
  environment_variables = {
    SECRET_ARN = module.rds.master_user_secret
    DB_HOST    = module.db_proxy.db_proxy_endpoint
    DB_NAME    = module.rds.db_name
  }
  subnet_ids         = [for az in keys(var.azs) : aws_subnet.lambda[az].id]
  security_group_ids = [aws_security_group.lambda.id]
}

module "lambda_layer" {
  source = "../modules/lambda_layer_python"

  layer_name  = "${local.prefix}-layer"
  runtime     = "python3.10"
  source_file = "lambda/lambda_proxy_access/requirements.txt"
}
