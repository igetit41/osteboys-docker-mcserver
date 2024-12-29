#!/bin/bash

export GITPATH=/home/d3f1l3/osteboys-docker-mcserver

sudo git config --global --add safe.directory '*'

sudo git -C $GITPATH reset --hard
sudo git -C $GITPATH pull origin main

sudo chmod +x $GITPATH/minecraftserver/minecraftserver.sh

sudo cp $GITPATH/minecraftserver/minecraftserver.service /etc/systemd/system/minecraftserver.service

sudo systemctl daemon-reload
sudo systemctl restart minecraftserver

# Define the server port
SERVER_PORT=25565

# Docker container name
CONTAINER=minecraftserver

# Define interval between checks for player activity (in seconds)
CHECK_INTERVAL=60

# Max Idle Intervals
IDLE_COUNT=15

# Count Idle Intervals
COUNT=0

# Main loop
while true; do
    # Check the number of established connections on the server port
    PID=$(docker inspect -f '{{.State.Pid}}' $CONTAINER)
    CONNECTIONS=$(sudo nsenter -t $PID -n netstat | grep -w $SERVER_PORT | grep ESTABLISHED | wc -l)
    STAMP=$(date +'%Y-%m-%d:%H.%M:%S')
    echo "STARTUPLOG-$STAMP-CONNECTIONS: $CONNECTIONS"

    if [ $CONNECTIONS -gt 0 ]; then
        COUNT=0
    else
        COUNT=$(expr $COUNT + 1)
    fi
    echo "STARTUPLOG-$STAMP-COUNT: $COUNT"
    
    if [ $COUNT -gt $IDLE_COUNT ]; then
        echo "STARTUPLOG-$STAMP------------Shutting down"
        sudo poweroff
        break
    fi

    sleep $CHECK_INTERVAL
done
