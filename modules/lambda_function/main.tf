resource "aws_lambda_function" "main" {
  function_name = var.function_name

  role     = var.role_arn
  filename = data.archive_file.main-lambda.output_path
  handler  = var.handler
  runtime  = var.runtime
  timeout  = var.timeout
  layers   = var.lambda_layer_arn
  environment {
    variables = var.environment_variables
  }
  vpc_config {
    security_group_ids = var.security_group_ids
    subnet_ids         = var.subnet_ids
  }
  source_code_hash = data.archive_file.main-lambda.output_base64sha256
  depends_on       = [var.dependency_resources]
}

locals {
  # 指定されたディレクトリ内のファイルをリスト化（セットをリストに変換）
  source_files = tolist(fileset("./${var.source_file}", "**"))
}

output "source_files" {
  value = local.source_files
}

# Lambda関数のソースコードをテンプレートとして処理
data "template_file" "t_file" {
  for_each = toset(local.source_files) # source_files をセットに変換して反復処理
  template = file("./${var.source_file}/${each.value}")
}

# Lambdaのソースコードをzip化
data "archive_file" "main-lambda" {
  type        = "zip"
  output_path = ".terraform/tmp/lambda/${var.function_name}-code.zip"

  # 動的にsourceブロックを生成
  dynamic "source" {
    for_each = local.source_files
    content {
      filename = basename(source.value)                           # source.value はファイルパス
      content  = data.template_file.t_file[source.value].rendered # 各テンプレートのcontent
    }
  }
}




