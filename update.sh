#!/bin/dash

brew update
brew upgrade
brew -f cleanup


ssh vps brew update
sshbrew install mongosh vps 
