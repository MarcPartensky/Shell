#!/bin/sh

source ~/git/secrets/spotipy.sh
lsof -i:49153 | tail -1 | awk '{print $2}' | xargs -I @ kill @
~/.local/bin/sp$1 ${@:2}
