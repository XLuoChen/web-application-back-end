#!/bin/bash

if [ ! -d /tmp/target ]; then
    sudo mkdir -p /tmp/target
fi

sudo rm -rf /target
sudo cp -r /var/lib/jenkins/workspace/leafer/target/leafer-0.1.0.jar /tmp/target

cd /tmp/target

java -jar leafer-0.1.0.jar &

sleep 10
