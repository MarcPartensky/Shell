#!/bin/bash

# DOCKER_HOST=unix:///run/docker.sock
SERVICES_PATH=~/git/docker/services
FOCALBOARD_ELECTRON_PATH=~/git/focalboard-electron

docker compose -f $SERVICES_PATH/postgres.yml up -d postgres
docker compose -f $SERVICES_PATH/focalboard.yml up -d focalboard
electron $FOCALBOARD_ELECTRON_PATH
docker compose -f $SERVICES_PATH/postgres.yml rm -sf postgres
docker compose -f $SERVICES_PATH/focalboard.yml rm -sf focalboard
