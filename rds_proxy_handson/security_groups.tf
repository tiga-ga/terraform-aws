#########################################################################
# DB用セキュリティグループの生成
#########################################################################

resource "aws_security_group" "db" {
  name        = "${local.prefix}-db"
  description = "Security Group of database"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${local.prefix}-db"
  }
}

resource "aws_vpc_security_group_ingress_rule" "db_ingress" {
  security_group_id            = aws_security_group.db.id
  referenced_security_group_id = aws_security_group.db_proxy.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "db_egress" {
  security_group_id = aws_security_group.db.id
  from_port         = "-1"
  to_port           = "-1"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

#########################################################################
# DB Proxy用セキュリティグループの生成
#########################################################################

resource "aws_security_group" "db_proxy" {
  name        = "${local.prefix}-db-proxy"
  description = "Security Group of RDS Proxy"
  vpc_id      = aws_vpc.this.id
  tags = {
    Name = "${local.prefix}-db-proxy"
  }
}

resource "aws_vpc_security_group_ingress_rule" "db_proxy_ingress" {
  security_group_id            = aws_security_group.db_proxy.id
  referenced_security_group_id = aws_security_group.lambda.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "db_proxy_egress" {
  security_group_id = aws_security_group.db_proxy.id
  from_port         = "-1"
  to_port           = "-1"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

#########################################################################
# VPC Endpoint用セキュリティグループの生成
#########################################################################

resource "aws_security_group" "vpc_endpoint" {
  name        = "${local.prefix}-vpc-endpoint"
  description = "Security Group of VPC Endpoint"
  vpc_id      = aws_vpc.this.id
  tags = {
    Name = "${local.prefix}-vpc-endpoint"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc_endpoint_ingress" {
  security_group_id            = aws_security_group.vpc_endpoint.id
  referenced_security_group_id = aws_security_group.lambda.id
  from_port                    = 443 # HTTPSポート
  to_port                      = 443
  ip_protocol                  = "tcp"
}


resource "aws_vpc_security_group_egress_rule" "vpc_endpoint_egress" {
  security_group_id = aws_security_group.vpc_endpoint.id
  from_port         = "-1"
  to_port           = "-1"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}


#########################################################################
# lambda用セキュリティグループの生成
#########################################################################

resource "aws_security_group" "lambda" {
  name        = "${local.prefix}-lambda"
  description = "Security Group of Lambda"
  vpc_id      = aws_vpc.this.id
  tags = {
    Name = "${local.prefix}-lambda"
  }
}


resource "aws_vpc_security_group_egress_rule" "lambda_egress" {
  security_group_id = aws_security_group.lambda.id
  from_port         = "-1"
  to_port           = "-1"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}
