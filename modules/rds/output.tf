output "master_user_secret" {
  value = aws_db_instance.main.master_user_secret[0].secret_arn
}

output "db_identifier" {
  value = aws_db_instance.main.identifier
}

output "db_id" {
  value = aws_db_instance.main.id
}

output "db_name" {
  value = aws_db_instance.main.db_name
}
