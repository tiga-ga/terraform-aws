resource "aws_lambda_layer_version" "main" {
  layer_name          = var.layer_name
  filename            = data.archive_file.lambda_layer.output_path
  compatible_runtimes = [var.runtime]
  source_code_hash    = data.archive_file.lambda_layer.output_base64sha256
}

data "external" "lambda_layer" {
  program = ["../modules/lambda_layer_python/create_lambda_layer.sh", var.runtime, var.source_file]
}

data "archive_file" "lambda_layer" {
  type             = "zip"
  output_path      = ".terraform/tmp/lambda/${var.layer_name}.zip"
  source_dir       = data.external.lambda_layer.result.path
  output_file_mode = "0644"
}
