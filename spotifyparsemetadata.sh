#!/bin/sh

METADATA=/tmp/spotifymetadata
playerctl -p spotify metadata > $METADATA

title=`cat $METADATA | grep xesam:title | tr -s ' ' | awk '{$1=$2=""; print $0}'`
artist=`cat $METADATA | grep xesam:artist | tr -s ' ' | awk '{$1=$2=""; print $0}'`
album=`cat $METADATA | grep xesam:album | tr -s ' ' | awk '{$1=$2=""; print $0}'`

echo $title \| $artist \| $album
