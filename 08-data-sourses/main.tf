provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}


# получение и использование информации из облака


############# availability zones
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones
data "aws_availability_zones" "working" {}
output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}


############# get current caller identity

data "aws_caller_identity" "current" {}
output "data_aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}


############# get current region name
data "aws_region" "region" {}
output "data_aws_region_name" {
  value = data.aws_region.region.name
}
output "data_aws_region_description" {
  value = data.aws_region.region.description
}


############# get all my vpc-s
data "aws_vpcs" "my_vpcs" {}
output "data_aws_vpcs" {
  value = data.aws_vpcs.my_vpcs.ids
}


############# get vpc by tag name
data "aws_vpc" "my_vpc" {
  tags = {
    Name = "prod"
  }
}
output "data_aws_vpc" {
  value = data.aws_vpc.my_vpc.id
}


############# subnet
resource "aws_subnet" "my_subnet" {
  vpc_id = data.aws_vpc.my_vpc.id
  availability_zone = data.aws_availability_zones.working.names[0]
  cidr_block = "10.10.1.0/24"
  tags = {
    NameE = "Subnet ${data.aws_availability_zones.working.names[0]}"
    Account = "Subnet in account ${data.aws_caller_identity.current.account_id}"
  }
}
