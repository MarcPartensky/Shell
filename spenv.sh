#!/bin/sh

source ~/git/secrets/spotipy.sh
kill `lsof -i:49153 | tail -1 | awk '{print $2}'`
~/.local/bin/sp$1 ${@:2}
