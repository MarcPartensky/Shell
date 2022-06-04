#!/bin/sh

# playerctl wrapper for spotify music only

# playerctl -l | grep spotifyd && playerctl -p spotifyd $@ || playerctl -p spotify $@

playerctl -p spotify $@
playerctl -p spotifyd $@
