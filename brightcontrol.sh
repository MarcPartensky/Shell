#!/bin/sh

operation=$1
value=$2

for cmd in brightnessctl ddcutil; do
    command -v $cmd > /dev/null || echo $cmd required
done

# get laptop brightness
max_brightness=`brightnessctl m`
brightness=`brightnessctl get`
percent_brightness=$(( (brightness * 100) / max_brightness ))

# check which operations
if [ "$operation" = "add" ]; then
    delta=$value
    new_percent_brightness=$((percent_brightness + $delta))
elif [ "$operation" = "set" ]; then
    new_percent_brightness=$value
else
    echo "Usage: brightcontrol [operation] [value]

      [Operations]
        add Add the brightness
        set Set the brightness
      [Examples]
        brightcontrol set 10
        brightcontrol add 5
        brightcontrol add -2
    "
    exit 0
fi

# find the new laptop brightness
new_brightness=$(((new_percent_brightness * $max_brightness) / 100))

# log if env var is set
if test -n "$LOG_BRIGHTNESS" ; then
    echo brightness: $brightness
    echo max_brightness: $max_brightness
    echo percent_brightness: $percent_brightness
    echo new_brightness: $new_brightness
    echo 
fi

# set brightness laptop
brightnessctl s $new_brightness > /dev/null

# set brightness external monitor
# monitor_brightness=`ddcutil getvcp 10 | grep Brightness | grep -Po "\\d+" | head -n 3 | tail -n 1`
# new_monitor_brightness=$(($monitor_brightness + $delta))
# ddcutil setvcp 10 $new_monitor_brightness
ddcutil setvcp 10 $new_percent_brightness > /dev/null

# logs
echo brightness: $percent_brightness% -\> $new_percent_brightness%
