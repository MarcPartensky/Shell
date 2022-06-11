#!/bin/sh

source ~/git/secrets/spotipy.sh

~/.local/bin/sp$1 ${@:2}
