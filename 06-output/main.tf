provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

locals {
  web_user_data = templatefile("user_data.sh.tpl", {
    f_name = "Ivan"
    l_name = "Petrov"
    names  = ["Tert", "Rister", "Lago", "Test"]
  })
}

# re-create ec2 without downtime: 1) create new ec2 2) destroy old ec2
resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
}

resource "aws_instance" "my_webserver" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data              = local.web_user_data

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Instance = "web-server",
    Lolo     = "lo-lo"
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "Dynamic security group"
  description = "Dynamic security group description"

  # open ports on loop
  dynamic "ingress" {
    for_each = ["80", "443", "1541", "9092"]
    content {
      description = "Dynamic security group port"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # откуда принимать соединения - отовсюду
    }
  }

  # special port
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
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
