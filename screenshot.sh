#!/bin/sh

filepath=~/Pictures/`date +%Y-%m-%d_%H:%M:%S`.png
grim -g "$(slurp)" $filepath | wl-copy
cat $filepath | xclip -selection clipboard -t image/png
notify-send -i $filepath $filepath
notify-send -i $filepath `imgur.sh $filepath`
# scrot -f ~/Pictures/%Y-%m-%d_%H:%M:%S.png -s -e 'xclip -selection clipboard -target image/png -i $f'
