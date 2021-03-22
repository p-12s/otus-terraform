#!/bin/bash
yum -y update
yum -y install httpd
my_ip=`curl https://ipecho.net/plain`
echo "<h1>Hello!<br>WebServer with IP: $my_ip</h1><p>Build with terraform</p>" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
