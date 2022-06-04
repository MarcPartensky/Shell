#!/bin/sh

notify-send $XDG_RUNTIME_DIR
~/.local/bin/spenv spcurrent > /tmp/song
notify-send "$(cat /tmp/song)"
