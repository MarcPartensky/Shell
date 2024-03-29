#!/bin/sh

BATTINFO=`acpi -b | cut -c 12- | sed 's/%, /%\n/g' | sed 's/,/:/g'`
if [[ `echo $BATTINFO | grep Discharging` && `echo $BATTINFO | tail -n 1 | cut -f 1 -d " "` < 00:15:00 ]]
then
    DISPLAY=:0.0 /usr/bin/notify-send -u critical -t 10000 "Low battery" "$BATTINFO"
fi
