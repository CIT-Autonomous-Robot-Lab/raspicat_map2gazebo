#!/bin/bash
CONTAINER_ID=map2gazebo

while :; do 
    LOG_OUTPUT=$(docker logs --tail 100 $CONTAINER_ID 2>&1)
    if echo "$LOG_OUTPUT" | grep -q "Exported STL.  You can shut down this node now"; then
        echo "Detected the log message. Shutting down the container."
        docker stop $CONTAINER_ID
        break
    fi
    sleep 1
done
