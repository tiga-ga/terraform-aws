#########################################################################
# DB用のプライベートサブネット,サブネットグループ
#########################################################################

resource "aws_subnet" "db" {
  for_each                = var.azs
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.db_cidr
  availability_zone       = "${data.aws_region.current.name}${each.key}"
  map_public_ip_on_launch = false

  tags = {
    Name = "${local.prefix}-db-${each.key}"
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${local.prefix}-db"
  subnet_ids = [for az in keys(var.azs) : aws_subnet.db[az].id]
  tags = {
    Name = "${local.prefix}-db"
  }
}

#########################################################################
# DB Proxy用のサブネット
#########################################################################

resource "aws_subnet" "db_proxy" {
  for_each                = var.azs
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.db_proxy_cidr
  availability_zone       = "${data.aws_region.current.name}${each.key}"
  map_public_ip_on_launch = false

  tags = {
    Name = "${local.prefix}-db-proxy-${each.key}"
  }
}

#########################################################################
# Lambda用のサブネット
#########################################################################

resource "aws_subnet" "lambda" {
  for_each                = var.azs
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.lambda_cidr
  availability_zone       = "${data.aws_region.current.name}${each.key}"
  map_public_ip_on_launch = false

  tags = {
    Name = "${local.prefix}-lambda-${each.key}"
  }
}

#########################################################################
# VPC Endpoint(SecretsManager)用のサブネット
#########################################################################

resource "aws_subnet" "vpc_endpoint" {
  for_each                = var.azs
  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.vpc_endpoint_cidr
  availability_zone       = "${data.aws_region.current.name}${each.key}"
  map_public_ip_on_launch = false

  tags = {
    Name = "${local.prefix}-vpc-endpoint-${each.key}"
  }
}



