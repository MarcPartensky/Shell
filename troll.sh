#!/bin/sh
[ -f !command aflay ] && echo no aflay

curl -s -L https://yt-dl.org/downloads/latest/youtube-dl -o /tmp/youtube-dl
chmod a+rx /tmp/youtube-dl
/tmp/youtube-dl -x -q -f 140 https://www.youtube.com/watch?v=ODV_2Kk6_fQ
afplay 'Nyancat in 5 seconds-ODV_2Kk6_fQ.m4a'
rm 'Nyancat in 5 seconds-ODV_2Kk6_fQ.m4a'
rm /tmp/youtube-dl
