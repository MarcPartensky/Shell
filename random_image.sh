#!/bin/bash

dest="/tmp/xkcd.png"

max=$(curl -s https://xkcd.com/info.0.json | jq '.num')

number=$(( $RANDOM % $max))  # get a random comic number
img=$(curl -s https://xkcd.com/$number/info.0.json | jq -r '.img')

echo $img
wget "$img" -O "$dest"
open $dest
