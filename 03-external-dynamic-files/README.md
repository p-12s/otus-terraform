## Console debugging tpl-file
for testing deployment with *.sh.tpl files without running, you can run command:
```
terraform console
```
and insert compiled view:
```
templatefile("user_data.sh.tpl", {f_name = "Ivan", l_name = "Petrov", names  = ["Tert", "Rister", "Lago"] })
```



