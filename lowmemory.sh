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
WARNING=$(expr $total / 2)
CRITICAL=$(expr $total / 10)

# -h int:transient:1 <-- don't store the notification
# https://unix.stackexchange.com/questions/393397/get-notify-send-to-clear-itself-from-notification-tray/401587
if [ $available -lt $CRITICAL ]; then
    # using -u critical doesn't allow the notification to go away after -t ms have past
    # this causes issues if afk, since the notifications will queue until the -u critical is closed
    notify-send -i error -h int:transient:1 -t 60000 "Low memory!" "$available/$total MB free, critical at $CRITICAL MB"
elif [ $available -lt $WARNING ]; then
    notify-send -h int:transient:1 -t 15000 "Memory is going low" "Available: $available/$total MB, warns at $WARNING MB"
fi

# outputs if not ran by cron
# https://unix.stackexchange.com/questions/46789/check-if-script-is-started-by-cron-rather-than-invoked-manually
if [ -t 0 ]; then
    echo "Available: $available/$total MB, warns at $WARNING MB, critical at $CRITICAL MB"
fi
