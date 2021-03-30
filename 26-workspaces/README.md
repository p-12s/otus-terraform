## Workspaces - feature for testing infrastructure

commands:
```
terraform workspace show
terraform workspace list        # all 
terraform workspace new NAME         # create and checkout
terraform workspace select NAME      # just checkout
terraform workspace delete NAME
```
using in wariable - ${terraform.workspace}
