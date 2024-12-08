provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      user    = "tiga"
      purpose = "rds_proxy"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"
    }
  }

  required_version = ">= 1.8.3"
}
