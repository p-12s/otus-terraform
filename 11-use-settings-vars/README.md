## Use variables

1) using var-files variables.tf.   
by default, used file terraform.tfvars and simple command:
```
terraform apply --auto-approve
```
for special environment use file prod.auto.tfvars and command:  
```
terraform apply -var-file="prod.auto.tfvars"
```
2) input vars in cli:  
```
terraform plan -var="region=us-west-1" -var="instance_type=t2.micro"
```
3) input vars into env:
```
export TF_VAR_region=us-west-1
export TF_VAR_instance_type=t2.micro
env | grep TF_VAR_
```
if vars don't need anymore, delete it:
```
unset TF_VAR_region=us-west-1
env | grep TF_VAR_
```

