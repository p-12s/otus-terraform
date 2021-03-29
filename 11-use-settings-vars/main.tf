provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

locals {
  test_computed_var = "${var.ami}-${var.allow_ports[0]}"
  test_join = join(",", var.allow_ports)
}

# Provision highly available web in any region default VPC.
# Create:
# - security group for web server
# - launch configuration with auto AMI load
# - auto scaling group using 2 available zone
# - classic load balances in 2 available zone


# ---------------------------------------------------

data "aws_availability_zones" "available" {}
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2*-x86_64-*"]
  }
}

resource "aws_security_group" "my_webserver" {
  name = "Dynamic security group"

  # open ports on loop
  dynamic "ingress" {
    for_each = var.allow_ports
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
    TestTag = local.test_computed_var
  })
}

resource "aws_launch_configuration" "web" {
  name_prefix     = "WebServer-highly-available-lc" # name не нужно использовать - ругается на существующее имя при пересоздании
  image_id        = data.aws_ami.latest_amazon_linux.id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.my_webserver.id]
  user_data       = file("install_webserver.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web" {
  name                 = "ASG-${aws_launch_configuration.web.name}" # чтобы сервера были пересозданы, имя должно поменяться. поэтому смотрим
  launch_configuration = aws_launch_configuration.web.name
  max_size             = 2 # кол-во серверов
  min_size             = 2 # кол-во серверов
  min_elb_capacity     = 2 # кол-во успешных health-чеков, прежде чем load-балансер будет работать
  health_check_type    = "ELB"
  vpc_zone_identifier  = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id]
  load_balancers       = [aws_elb.web.name]

  dynamic "tag" {
    for_each = {
      Name  = "WebServer-in-ASG"
      Owner = "Me"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_elb" "web" {
  name               = "WebServer-HA-ELB"
  availability_zones = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  security_groups    = [aws_security_group.my_webserver.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    interval            = 10
    target              = "HTTP:80/"
    timeout             = 3
    unhealthy_threshold = 2
  }
  tags = {
    Name = "WebServer-HA-ELB"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available.names[0]
}
resource "aws_default_subnet" "default_az2" {
  availability_zone = data.aws_availability_zones.available.names[1]
}

output "web_load_balancer_url" {
  value = aws_elb.web.dns_name
}
