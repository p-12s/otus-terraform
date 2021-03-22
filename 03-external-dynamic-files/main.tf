provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

locals {
  web_user_data = templatefile("user_data.sh.tpl", {
    f_name = "Ivan"
    l_name = "Petrov"
    names  = ["Tert", "Rister", "Lago"]
  })
}

resource "aws_instance" "my_webserver" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = local.web_user_data

  tags = {
    Instance = "web-server"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "Web server security group"
  description = "Web server security group description"

  ingress {
    description = "Web server security group ingress descr 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # откуда принимать соединения - отовсюду
  }

  ingress {
    description = "Web server security group ingress descr 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # откуда принимать соединения - отовсюду
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # уходит на любой протокол
    cidr_blocks = ["0.0.0.0/0"] # уходит на любой адрес
  }

  tags = {
    Name = "my_webserver"
  }
}
