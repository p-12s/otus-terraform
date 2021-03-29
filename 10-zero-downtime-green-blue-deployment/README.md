## Zero downtime + green blue deployment
### !!! у меня почему-то downtime есть !!!
Provision highly available web in any region default VPC.  
Create:    
    - security group for web server  
    - launch configuration with auto AMI load  
    - auto scaling group using 2 available zone  
    - classic load balances in 2 available zone  
  
if default availability zone not created:
```
aws ec2 create-default-subnet --availability-zone eu-west-1b
```
