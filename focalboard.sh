#!/bin/bash

# DOCKER_HOST=unix:///run/docker.sock
SERVICES_PATH=~/git/docker/services
ELECTRON_PATH=~/git/custom-electron
ELECTRON_HOST=localhost:8000

docker compose -f $SERVICES_PATH/postgres.yml up -d postgres
docker compose -f $SERVICES_PATH/focalboard.yml up -d focalboard
HOST=$ELECTRON_HOST electron $ELECTRON_PATH
docker compose -f $SERVICES_PATH/postgres.yml rm -sf postgres
docker compose -f $SERVICES_PATH/focalboard.yml rm -sf focalboard
