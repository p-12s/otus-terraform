## Additional moment
If recourse should be recreated, mark then as taint:
```
terraform taint aws_instance.NAME
terraform apply
```

