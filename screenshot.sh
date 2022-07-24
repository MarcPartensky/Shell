#!/bin/sh

filepath=~/Pictures/`date +%Y-%m-%d_%H:%M:%S`.png
maim -os $filepath
cat $filepath | xclip -selection clipboard -t image/png
notify-send "$filepath"
# scrot -f ~/Pictures/%Y-%m-%d_%H:%M:%S.png -s -e 'xclip -selection clipboard -target image/png -i $f'
