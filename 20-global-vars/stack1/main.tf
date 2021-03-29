provider "aws" {
  # доступы от текущего аккаунта
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
  alias      = "IRE"
}


data "terraform_remote_state" "global" {
  backend = "s3"
  config = {
    bucket = "p12s-otus-terraform"
    key    = "dev/network/terraform.tfstate"
    region = "eu-west-1"
  }
}

locals {
  company_name = data.terraform_remote_state.global.outputs.company_name
}
