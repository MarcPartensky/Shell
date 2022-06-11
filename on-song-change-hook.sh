#!/bin/sh

~/.local/bin/spenv current > /tmp/song
notify-send "$(cat /tmp/song)"
