# IAM Role for Lambda Function
module "lambda_role" {
  source = "../modules/iam_role"

  iam_role_name = "${local.prefix}-lambda-role"
  iam_assume_role_policy = {
    Effect = "Allow"
    Principal = {
      Service = "lambda.amazonaws.com"
    }
    Action = "sts:AssumeRole"
  }
  iam_policy_name = "${local.prefix}-lambda-policy"
  iam_policy_statements = [
    {
      Effect = "Allow"
      Action = [
        "secretsmanager:GetSecretValue"
      ]
      Resource = [
        module.rds.master_user_secret
      ]
    }
  ]
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  ]

  dependency_resources = [module.rds]
}


## IAM Role for RDS Proxy

module "proxy_role" {
  source = "../modules/iam_role"

  iam_role_name = "${local.prefix}-proxy-role"
  iam_assume_role_policy = {
    Effect = "Allow"
    Principal = {
      Service = "rds.amazonaws.com"
    }
    Action = "sts:AssumeRole"
  }
  iam_policy_name = "${local.prefix}-proxy-policy"
  iam_policy_statements = [
    {
      Effect = "Allow"
      Action = [
        "secretsmanager:GetSecretValue"
      ]
      Resource = [
        module.rds.master_user_secret
      ]
    }
  ]
  managed_policy_arns = []

  dependency_resources = [module.rds]
}
