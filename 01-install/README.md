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
