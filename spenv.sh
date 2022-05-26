#!/bin/sh

source ~/git/secrets/spotipy.sh
[[ $1 == 'splike' ]] && ~/.local/bin/splike ${@:2}
[[ $1 == 'spseek' ]] && ~/.local/bin/spseek ${@:2}
