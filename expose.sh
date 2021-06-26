#!/bin/bash

echo -n Password:
read -s password
local random_port=$(randomvpsport)
local host=${2:-"localhost"}
local port=${1:-1}
ssh -i expose@marcpartensky.com -p 7022 "comm -23 <(seq 8000 8099 | sort) <(ss -Htan | awk '{print $4}' | cut -d':' -f2 | sort -u) | shuf | head -n $port"
echo "marcpartensky.com:$random_port"
ssh -R $random_port:$host:$1 expose@marcpartensky.com -N -p 7022

