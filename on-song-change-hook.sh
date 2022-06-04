#!/bin/sh

~/.local/bin/spenv spcurrent > /tmp/song
notify-send "$(cat /tmp/song)"
