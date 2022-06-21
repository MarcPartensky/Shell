#!/bin/sh

docker run --rm -d \
    --network host \
    -e DISPLAY \
    -v /home/marc/.config/3T:/root/.config/3T \
    -v /home/marc/.3T:/root/.3T \
    -v /home/marc/.ssh/id_rsa:/root/.ssh/id_rsa \
    -v /home/marc/.ssh/config:/root/.ssh/config \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -t robo3t \
    marcpartensky/robo3t
