# 全てのアウトプットを取得
output "lambda_output_all" {
  value = module.lambda_function
}

output "lambda_layer_output_all" {
  value = module.lambda_layer
}

output "rds_output_all" {
  value = module.rds
}

output "db_proxy_output_all" {
  value = module.db_proxy
}

output "lambda_role_output_all" {
  value = module.lambda_role
}

output "proxy_role_output_all" {
  value = module.proxy_role
}
