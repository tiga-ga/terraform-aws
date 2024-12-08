#########################################################################
# RDS Instance
#########################################################################
module "rds" {
  source                      = "../modules/rds"
  db_instance_identifier      = "${local.prefix}-db"
  db_name                     = "main"
  vpc_security_group_id       = [aws_security_group.db.id]
  username                    = "admin"
  manage_master_user_password = true
  db_subnet_group_name        = aws_db_subnet_group.this.name
}


