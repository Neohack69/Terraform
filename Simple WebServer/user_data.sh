#!/bin/bash
  apt-get update
  apt-get install httpd
  echo "<h1>My first automated WebServer!!!<h1>" > /var/www/html/index.html
  sudo service httpd start
  chkconfig httpd on