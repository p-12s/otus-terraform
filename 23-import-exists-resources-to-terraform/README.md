## Resources
- We have got exist resourses
- Create simple (empty) code
```
resourse "aws_instance" "my_web" {

}
```
- run commands:
```
terraform init
terraform import aws_instance.my_web INSTANCE_ID
```
- run command
```
terraform apply
```
- edit scenario in tf-file, until it becomes the same
```
Apply complete! Resources: 0 added, 0 changed, 0 destroyed
```



