## Terraform install (tfenv)
MacOS:
```
brew install tfenv
```
check all available package versions:
```
tfenv list-remote
```
then pick and apply one:
```
tfenv install 0.14.8
tfenv use 0.14.8
```
check terraform version (you may need to restart zsh):
```
terraform --version
```
## Create user on AWS
Go to IAM, steps:   
1) add user, input name + Access type = "Programmatic access"  
2) attach existing policies directly + AdministratorAccess  
3) skip  
4) create user  

Create variables file variables.tf + terraform.tfvars  
or input vars into MacOS system before run terraform command:
```
export AWS_ACCESS_KEY_ID=####
export AWS_SECRET_ACCESS_KEY=####
export AWS_DEFAULT_REGION=####
```
