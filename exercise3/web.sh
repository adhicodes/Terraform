#!/bin/bash
yum install wget unzip httpd -y
systemctl start httpd
systemctl enable httpd
wget https://www.tooplate.com/zip-templates/2122_nano_folio.zip
unzip -o 2122_nano_folio.zip
cp -r 2122_nano_folio/* /var/www/html
systemctl restart httpd