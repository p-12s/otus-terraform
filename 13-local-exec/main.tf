provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "echo terraform start: ${date} >> log.txt"
  }
}

resource "null_resource" "command2" {
  depends_on = [null_resource.command1]
  provisioner "local-exec" {
    command = "mysql -u ${aws_db_instance_username} -p${aws_db_instance_password} -h ${aws_db_instance_address} < file.sql"
  }
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    command = "ping -c 5 google.com"
  }
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
    command     = "print('Hello!')"
    interpreter = ["python", "-c"]
  }
}

resource "null_resource" "command5" {
  provisioner "local-exec" {
    command = "echo $NAME1 $NAME2 >> name.txt"
    environment {
      NAME1 = "word1"
      NAME2 = "word2"
    }
  }
}
