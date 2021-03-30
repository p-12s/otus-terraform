## Refactoring remote state

### Safety commands: 
```
terraform state show aws_instance.NAME
terraform state list
terraform state pull > myfile.txt
```

### Not safety commands:
Refactoring remote state.    
1) extract remote state:
```
terraform state mv -state-out="terraform.tfstate" aws_eip.NAME aws_eip.NEW_NAME
```
check remaining resources and move them similarly:
```
terraform state list
terraform state mv -state-out="terraform.tfstate" RESOURSE-NAME RESOURSE-NAME
```
you can run each recourse, or run command for all:
```
for x in $(terraform state list | grep xyz); do terraform state mv -state-out=”terraform.tfstate” $x $x; done
```
2) run and rewrite remote state:
```
terraform init

- do you want to copy ..?
YES
```
3) check result (shouldn't be changes):
```
terraform apply

Apply complete! Resources: 0 added, 0 changed, 0 destroyed
```
4) if you need - you can remove resource data (not necessary):
```
terraform state list
terraform state rm data.aws_ami.latest_amazon_linux
```
after that, the recourse cannot be controlled by terraform.  
5) remove old terraform folder
6) if you need - you can push changes into remote state
```
terraform push
```
