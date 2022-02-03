#!/bin/sh

apt-get update
apt-get upgrade -y
apt-get install -y curl
. <(curl https://get.docker.com)
