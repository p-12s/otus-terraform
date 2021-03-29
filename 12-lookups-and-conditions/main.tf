provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

variable "allow_port_list" {
  default = {
    "prod" = ["80", "443"]
    "dev" = ["80", "443", "8080", "22"]
  }
}

resource "aws_instance" "my_webserver" {
  ami = var.ami
  instance_type = var.env == "prod" ? var.ec2_size.prod : var.ec2_size.dev
}

resource "aws_instance" "my_dev_server" {
  count = var.env == "dev" ? 1 : 0
  ami = var.ami
  instance_type = lookup(var.ec2_size, "prod")
  tags = {
    Name = "Dev-server"
  }
}

resource "aws_security_group" "my_webserver" {
  name = "Dynamic security group"

  # open ports on loop
  dynamic "ingress" {
    for_each = lookup(var.allow_port_list, var.env)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # откуда принимать соединения - отовсюду
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # уходит на любой протокол
    cidr_blocks = ["0.0.0.0/0"] # уходит на любой адрес
  }

  // tags = var.tags OR
  tags = merge(var.tags, {
    Name = "my_webserver"
    Env = var.env
  })
}
