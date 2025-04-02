#!/usr/bin/env bash
# based from https://askubuntu.com/questions/234292/warning-when-available-ram-approaches-zero
LANG=en_US.UTF-8

# gets available and total ram
RAM=$(free -m)
total=$(echo "$RAM"|awk '/^[mM]em\.?:/{print $2}')
available=$(echo "$RAM"|awk '/^[mM]em\.?:/{print $7}')

# warn if less than these levels is free
# warning = 20%
# critical = 10%
warning_mb=$(expr $total / 3)
critical_mb=$(expr $total / 5)

available_gb=$(bc -l <<< "scale=2; $available / 1024")
used_gb=$(bc -l <<< "scale=2; $total / 1024 - $available / 1024")

critical_gb=$(bc -l <<< "scale=2; $critical_mb / 1024")
warning_gb=$(bc -l <<< "scale=2; $warning_mb / 1024")

percentage=$(echo "100-$available*100/$total" | bc)

mb="Mb"
gb="Gb"

# -h int:transient:1 <-- don't store the notification
# https://unix.stackexchange.com/questions/393397/get-notify-send-to-clear-itself-from-notification-tray/401587
if [ $available -lt $critical_mb ]; then
    # using -u critical doesn't allow the notification to go away after -t ms have past
    # this causes issues if afk, since the notifications will queue until the -u critical is closed
    notify-send -u critical -i error -h int:transient:1 -t 60000 "Critical low memory!" "$used_gb$gb used: $percentage%"
elif [ $available -lt $warning_mb ]; then
    notify-send -u normal -h int:transient:1 -t 15000 "Warning low memory" "$used_gb$gb used: $percentage%"
fi

# outputs if not ran by cron
# https://unix.stackexchange.com/questions/46789/check-if-script-is-started-by-cron-rather-than-invoked-manually
if [ -t 0 ]; then
    echo "Available: $available/$total MB, warns at $warning_mb MB, critical at $critical_mb MB"
fi
