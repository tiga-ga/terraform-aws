##################################################
# RDSインスタンス
##################################################
resource "aws_db_instance" "main" {
  identifier                  = var.db_instance_identifier
  db_name                     = var.db_name
  allocated_storage           = var.allocated_storage
  engine                      = var.engine
  engine_version              = var.engine_version
  instance_class              = var.instance_class
  username                    = var.username
  password                    = var.manage_master_user_password ? null : var.password
  manage_master_user_password = var.manage_master_user_password
  parameter_group_name        = var.parameter_group_name
  skip_final_snapshot         = var.skip_final_snapshot
  db_subnet_group_name        = var.db_subnet_group_name
  vpc_security_group_ids      = var.vpc_security_group_id
}
