#!/bin/sh

source ~/git/secrets/spotipy.sh

# search first player between spotify and spotube
player=`playerctl -l | grep spot | head -1`
cmds="play pause play-pause next prev"

for cmd in $cmds
do
    if [ $1 = "$cmd" ]
    then
        playerctl -p $player $cmd
        exit 0
    fi
done

lsof -i:49153 | tail -1 | awk '{print $2}' | xargs -I @ kill @
~/.local/bin/sp$1 ${@:2}
