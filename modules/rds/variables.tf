variable "db_instance_identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the RDS instance"
  type        = string

}
variable "allocated_storage" {
  description = "The allocated storage size for the RDS instance"
  type        = number
  default     = 20
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "8.0"
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "username" {
  description = "The master username for the database"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "The master password for the database"
  type        = string
  default     = "password"
}

variable "manage_master_user_password" {
  description = "Whether to manage the master user password"
  type        = bool
  default     = true
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
  default     = "default.mysql8.0"
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot before deleting the DB"
  type        = bool
  default     = true
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "vpc_security_group_id" {
  description = "The ID of the security group for the RDS instance"
  type        = list(string)
}
