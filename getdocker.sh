#!/bin/sh

# Get docker on debian

# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc -y

# Update
sudo apt-get update

# Install dependencies
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

# Add docker official gpg key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# Add apt repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Policy check
apt-cache policy docker-ce

# If you want to avoid typing sudo whenever you run the docker command, add your username to the docker group
sudo usermod -aG docker ${USER}
