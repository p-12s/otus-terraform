variable "access_key" {
  type = string
}
variable "secret_key" {
  type = string
}
variable "region" {
  type = string
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "allow_ports" {
  default = ["80", "8080", "443", "22"]
  type    = list(string)
}
variable "boolean_true" {
  type = bool
}
variable "env" {
  type = string
}
variable "tags" {
  type = map(string)
  default = {
    Owner = "Me"
  }
}
variable "ec2_size" {
  type = map(string)
  default = {
    prod    = "t3.micro"
    dev     = "t2.micro"
    staging = "t2.small"
  }
}
