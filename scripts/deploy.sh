#!/bin/bash

if [ ! -d /var/www/html ]; then
    sudo mkdir -p /var/www/html
fi

rm -rf /var/www/html/leafer
sudo cp -r /var/lib/jenkins/workspace/leafer /var/www/html

cd /var/www/html/leafer

mysql < ./db_config.sql
mysql -u root -p root < ./leafer.sql

sudo apt install maven

mvn clean install
mvn spring-boot:run
