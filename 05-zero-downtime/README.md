## Lifecycles
if server cannot be restarted:
```
resource "aws_instance" "my_webserver" {
  ...

  lifecycle {
    prevent_destroy = true
  }
}
```
you can specify ignored parameters that can cause a server restart:
```
  ...
    lifecycle {
        ignore_changes = ["ami", "user_data"]
    }
  ...
```
create before destroy:
```
resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
}

resource "aws_instance" "my_webserver" {
  ...

  lifecycle {
    create_before_destroy = true
  }
}
```
