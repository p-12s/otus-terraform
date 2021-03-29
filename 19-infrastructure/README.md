## Infrastructure
View:
```
modules
    aws_network
        main.tf
projectA
    prod
        kms
        network
        route53
        s3
        vpc (like controller)
            applications
                app1
                    - main.tf
                app2
                    - main.tf
            databases
                - main.tf
            ecs-cluster
                - main.tf
    dev
        ...
    staging
        ...
```
Rules:
- all work throw remote state (keep file terraform.tfstate in s3-backet)
- repeated code in modules

