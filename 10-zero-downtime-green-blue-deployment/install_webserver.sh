#!/bin/bash
yum -y update
yum -y install httpd
my_ip=`curl https://ipecho.net/plain`
echo "<h1 style='color:aqua'>Hello!<br>WebServer with IP: $my_ip</h1><p>Build with terraform</p>" > /var/www/html/index.html
echo "<h2 style='color:red'>ZERO DOWNTIME BLUE_GREEN DEPLOYMENT</h2>" >> /var/www/html/index.html
echo "<br><br><h3 style='color:green;font-size:40px'>v.2</h2>" >> /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
