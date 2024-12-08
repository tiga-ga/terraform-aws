#########################################################################
# DB Proxyの作成
#########################################################################
module "db_proxy" {
  source                 = "../modules/db_proxy"
  proxy_name             = "${local.prefix}-db-proxy"
  role_arn               = module.proxy_role.iam_role_arn
  vpc_security_group_ids = [aws_security_group.db_proxy.id]
  secret_arn             = module.rds.master_user_secret
  vpc_subnet_ids         = [for az in keys(var.azs) : aws_subnet.db_proxy[az].id]
  dependency_resources   = [module.rds]
  db_identifier          = module.rds.db_identifier
  require_tls            = false //Todo：tureの場合はLambdaに証明書を追加する必要がある。その対応は後ほど
}
