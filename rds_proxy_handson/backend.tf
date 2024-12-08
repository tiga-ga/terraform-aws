terraform {
  backend "s3" {
    bucket = "tiga-terraform-aws-tfstate" # Change this to your bucket name
    key    = "terraform/rds_proxy_handson/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
