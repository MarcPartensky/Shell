#!/bin/bash

SERVICE=$1
ELECTRON_HOST=$2

# DOCKER_HOST=unix:///run/docker.sock
SERVICES_PATH=~/git/docker/services
ELECTRON_PATH=~/git/custom-electron

docker compose -f $SERVICES_PATH/postgres.yml up -d postgres
docker compose -f $SERVICES_PATH/$SERVICE.yml up -d $SERVICE
HOST=$ELECTRON_HOST electron $ELECTRON_PATH
docker compose -f $SERVICES_PATH/postgres.yml rm -sf postgres
docker compose -f $SERVICES_PATH/$SERVICE.yml rm -sf $SERVICE
