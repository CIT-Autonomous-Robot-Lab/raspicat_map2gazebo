#!/bin/bash

if [ $# -lt 6 ]; then
    echo "Usage: $0 <path1> <path2> <path3> <world_name> <author_name> <email>"
    exit 1
fi

path1=$(echo $1 | sed 's|/install/.*/share|/src|')
path2=$(echo $2 | sed 's|/install/.*/share|/src|')
path3=$(echo $3 | sed 's|/install/.*/share|/src|')

docker run --rm -t \
           -u $(id -u):$(id -g) \
           --privileged \
           --net=host \
           --ipc=host \
           -v $path1:$path1 \
           -v $path2:$path2 \
           -v $path3:/home/runner/catkin_ws/src/map2gazebo_docker/config \
           --name map2gazebo \
           ghcr.io/uhobeike/map2gazebo:melodic /bin/bash -i -c "roslaunch map2gazebo_docker map2gazebo.launch map_file:=$path1 world_name:=$4 author_name:=$5 email:=$6"
