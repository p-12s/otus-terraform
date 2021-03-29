provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}


# поиск последних AMI:
#   ubuntu 18.04
#   amazon linux 2


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
#   ubuntu 18.04
data "aws_ami" "latest_ubuntu" {
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}
output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}
output "latest_ubuntu_ami_description" {
  value = data.aws_ami.latest_ubuntu.description
}


#   amazon linux 2
data "aws_ami" "latest_amazon_linux_2" {
  owners = ["137112412989"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-2*-x86_64-*"]
  }
}

output "latest_amazon_linux_2_ami_id" {
  value = data.aws_ami.latest_amazon_linux_2.id
}
output "latest_amazon_linux_2_ami_name" {
  value = data.aws_ami.latest_amazon_linux_2.name
}
output "latest_amazon_linux_2_ami_description" {
  value = data.aws_ami.latest_amazon_linux_2.description
}
