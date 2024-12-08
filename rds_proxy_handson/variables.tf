## Variables
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type = map(object({
    db_cidr           = string
    db_proxy_cidr     = string
    lambda_cidr       = string
    vpc_endpoint_cidr = string
  }))
  default = {
    a = {
      db_cidr           = "10.0.16.0/24"
      db_proxy_cidr     = "10.0.18.0/24"
      lambda_cidr       = "10.0.20.0/24"
      vpc_endpoint_cidr = "10.0.22.0/24"
    },
    c = {
      db_cidr           = "10.0.17.0/24"
      db_proxy_cidr     = "10.0.19.0/24"
      lambda_cidr       = "10.0.21.0/24"
      vpc_endpoint_cidr = "10.0.23.0/24"
    }
  }
}
