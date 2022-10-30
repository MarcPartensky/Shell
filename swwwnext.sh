#!/usr/bin/env zsh

N=`/bin/ls ~/wallpapers | wc -l`
swww img \
    -t grow \
    --transition-pos 0,1080 \
    ~/wallpapers/$(( $RANDOM % $N + 1 )).jpg
