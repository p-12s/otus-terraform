#!/bin/bash
yum -y update
yum -y install httpd

my_ip=`curl https://ipecho.net/plain`

cat <<EOF > /var/www/html/index.html
<html>
<h1>Hello!<br>WebServer with IP: $my_ip</h1>
<p>Build with terraform</p>
Mister's name: ${f_name} ${l_name}.<br>

%{ for x in names ~}
Hello to ${x} from me<br>
%{ endfor ~}

</html>
EOF

sudo service httpd start
chkconfig httpd on
