#!/bin/bash

DEPLOY_LOCATION=/home/user1

echo $(date "+%Y.%m.%d-%H.%M.%S") 

echo "INFO: Stopping Tomcat Server..."

sudo systemctl stop app.service &
echo $(date "+%Y.%m.%d-%H.%M.%S") 

sleep 20

echo "INFO:Tomcat server Stopped!" 

buildver="${1:-not-passed-in}"
if [ -z "$1" ]; then
    echo "WARN: ############################ :WARN"
    echo "WARN: build version not passed in! :WARN"
    echo "WARN: ############################ :WARN"
fi

echo "INFO: Unzipping artifact zip folder" 
unzip -o 'ROOT.zip' -d "${DEPLOY_LOCATION}" &>/dev/null
echo $(date "+%Y.%m.%d-%H.%M.%S")

echo "INFO: cleaning Tomcat Container..."
mvn release &>/dev/null

echo "INFO: Starting Tomcat Server..."
sudo systemctl start spp.service &

echo "INFO: Server should be up in few minutes"
echo $(date "+%Y.%m.%d-%H.%M.%S")
