#!/bin/sh

scrot ~/Pictures/%Y-%m-%d_%H:%M:%S.png -s -e 'xclip -selection clipboard -target image/png -i $f'