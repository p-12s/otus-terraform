## Ami autofinding with data sourse
how to prepare filters:  
1) go to "Launch instances"
2) copy AMI (ami-0d712b3e6e1f798ef)
3) Images -> AMIs and find in public images
4) Copy owners and name
5) write
```
data "aws_ami" "latest_ubuntu" {
  owners = ["099720109477"] # owner
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"] # name with *
  }
}

output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}
```
