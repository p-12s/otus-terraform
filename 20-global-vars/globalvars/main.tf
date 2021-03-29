provider "aws" {
  # доступы от текущего аккаунта
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
  alias      = "IRE"
}


terraform {
  backend "s3" {
    bucket = "p12s-otus-terraform"
    key    = "dev/network/terraform.tfstate"
    region = "eu-west-1"
  }
}

#==============================================================

output "company_name" {
  value = "THIS IS GLOBAL COMPANY NAME"
}
