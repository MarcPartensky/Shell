#!/bin/sh

DOCKER_HOST=unix:///run/docker.sock
SERVICES_PATH=~/git/docker/services

docker compose -f $SERVICES_PATH/postgres.yml up -d postgres
docker compose -f $SERVICES_PATH/focalboard.yml up -d focalboard
firefox localhost:8000
