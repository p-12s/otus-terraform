## Data sourses
[docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones)  
list of availability zones:
```
data "aws_availability_zones" "working" {}
output "data_aws_availability_zones" {
  value = data.aws_availability_zones.working.names
}
```
