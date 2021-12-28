#!/usr/bin/env sh

# Remove invasive routing rules of vpns to be override those already defined

echo Removed:
ip route | grep 0.0.0.0/1 | while read line; do
    echo -e " - \033[1m$line\033[0m"
    sudo ip route del $line
done
ip route | grep 128.0.0.0/1 | while read line; do
    echo -e " - \033[1m$line\033[0m"
    sudo ip route del $line
done
