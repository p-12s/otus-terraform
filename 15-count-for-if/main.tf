provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

variable "aws_users" {
  description = "list of users"
  default = ["ivan", "petro", "max"]
}

resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name = element(var.aws_users, count.index)
}

output "created_users" {
  value = [
    for user in aws_iam_user.users:
           "Username: ${user.name} has ARN: ${user.arn}"
  ]
}

output "custom_if_length" {
  value = [
    for x in aws_iam_user.users:
          x.name
          if length(x.name) == 4
  ]
}

output "custom_if_length_2" {
  value = {
  for x in aws_iam_user.users:
    x.name => x.arn
  }
}
