## Depends on
use view:
```
resource "aws_instance" "my_webserver" {
  ...
  depends_on = [aws_instance.my_webserver_db]
  ...
}
resource "aws_instance" "my_webserver_db" {
  ...
}
```
