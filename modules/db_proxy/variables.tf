variable "proxy_name" {
  description = "The name of the RDS Proxy"
  type        = string
}

# デバッグロギングの有効化
variable "debug_logging" {
  description = "Enable debug logging for RDS Proxy"
  type        = bool
  default     = false
}

# RDS Proxy のエンジンファミリー
variable "engine_family" {
  description = "The engine family for the RDS Proxy (e.g., MYSQL, POSTGRESQL)"
  type        = string
  default     = "MYSQL"
}

# アイドルクライアントタイムアウト
variable "idle_client_timeout" {
  description = "The idle client timeout for RDS Proxy"
  type        = number
  default     = 1800 # 30 minutes
}

# TLS が必要かどうか
variable "require_tls" {
  description = "Flag to specify if RDS Proxy requires TLS"
  type        = bool
  default     = true
}

# IAM ロール ARN
variable "role_arn" {
  description = "The ARN of the IAM role associated with RDS Proxy"
  type        = string
}

# VPC セキュリティグループ IDs
variable "vpc_security_group_ids" {
  description = "List of security group IDs associated with RDS Proxy"
  type        = list(string)
}

# VPC サブネット IDs
variable "vpc_subnet_ids" {
  description = "List of subnet IDs for RDS Proxy"
  type        = list(string)
}

# 認証設定 - IAM 認証の有効化フラグ
variable "iam_auth" {
  description = "Enable IAM authentication for RDS Proxy"
  type        = string
  default     = "DISABLED"
}

# Secrets Manager のシークレット ARN
variable "secret_arn" {
  description = "The ARN of the Secrets Manager secret for RDS Proxy authentication"
  type        = string
  default     = ""
}

# 依存リソース
variable "dependency_resources" {
  description = "List of resources that RDS Proxy depends on"
  type        = list(any)
}

# データベースインスタンスの ID
variable "db_identifier" {
  description = "The DB instance identifier to attach to the RDS Proxy target group"
  type        = string
}
