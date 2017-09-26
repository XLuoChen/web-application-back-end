#!/bin/bash

if [ ! -d /var/www/html ]; then
    sudo mkdir -p /var/www/html
fi

sudo rm -rf /var/www/html/leafer
sudo cp -r /var/lib/jenkins/workspace/leafer /var/www/html

cd /var/www/html/leafer

mysql -u root -proot < /var/lib/jenkins/workspace/leafer/scripts/leafer.sql

sudo apt install -y maven

sudo mvn clean install
sudo mvn spring-boot:run &
