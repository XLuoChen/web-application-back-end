#!/bin/bash

ssh remote@192.168.30.12

if [ ! -d /tmp/target ]; then
    sudo mkdir -p /tmp/target
fi

sudo rm -rf /target
scp -r /var/lib/jenkins/workspace/leafer/target/leafer-0.1.0.jar 192.168.30.12:/tmp/target

cd 192.168.30.12:/tmp/target

java -jar leafer-0.1.0.jar &

sleep 10
