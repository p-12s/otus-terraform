## Conditions and lookup
### Conditions 
```
resource "aws_instance" "my_webserver" {
  ...
  instance_type = var.env == "prod" ? var.ec2_size.prod : var.ec2_size.dev
  ...
}
```
### Lookup 
```
resource "aws_instance" "my_webserver" {
  ...
  instance_type = lookup(var.ec2_size, "prod")
  ...
}
```
