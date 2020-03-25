#!/bin/bash

mkdir troll
cd troll
curl -s -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl
youtube-dl -x -q -f 140 https://www.youtube.com/watch?v=ODV_2Kk6_fQ
afplay 'Nyancat in 5 seconds-ODV_2Kk6_fQ.m4a'
cd ..
rm -r troll
