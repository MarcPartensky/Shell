#!/bin/sh

BATTINFO=`acpi -b | cut -c 12- | sed 's/%, /%\n/g' | sed 's/,/:/g'`
timeleft=`echo $BATTINFO | tail -n 1 | cut -f 3 -d " "`
echo $BATTINFO
if [[ `echo $BATTINFO | grep Discharging` &&  $timeleft < 00:30:00 ]]
then
    DISPLAY=:0.0 /usr/bin/notify-send -u critical -t 10000 "Low battery" "$BATTINFO"
fi
