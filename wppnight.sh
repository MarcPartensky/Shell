#!/bin/sh

image=$1
brightness=`convert $1 -colorspace hsb  -resize 1x1  txt:- | tail -1 | awk '{print $4}' | tr ",)%" " " | awk '{print $3}'`
limit=60
isunder=`echo "$brightness < 60" | bc -l`
under=`if (($isunder)); then echo under; else echo above; fi`

echo "$image brightness is $brightness and is $under the $limit"
