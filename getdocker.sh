#!/bin/sh

# Get docker on debian

# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc -y

# Update
sudo apt-get update

# Install dependencies
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add docker official gpg key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Install docker engine
 sudo apt-get update
 sudo apt-get install docker-ce docker-ce-cli containerd.io -y
