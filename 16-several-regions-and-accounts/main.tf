provider "aws" {
  # доступы от текущего аккаунта
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
  alias = "IRE"
}

provider "aws" {
  # можно указать доступы от другого аккаунта
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
  alias = "USA"
  # или указать роль, созданную другим админом для другого акка
  # assume_role {
  #   role_arn = "arn:aws:iam::1212121212:role/RemoteAdmin"
  #   session_name = "MY_SESSION"
  # }
}

data "aws_ami" "ire_latest_ubuntu" {
  provider = aws.IRE
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "my_webserver_ire" {
  provider = aws.IRE
  ami = data.aws_ami.ire_latest_ubuntu.id
  instance_type = var.instance_type
}

# USA - similarly
