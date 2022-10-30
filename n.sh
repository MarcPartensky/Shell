#!/usr/bin/env zsh

if ! [ "$MAIN_ENV" = "$HOST" ]
then
    if [ "$HOST" = "vps" ]
    then
        nbotnovps $@
    else
        nbot $@
    fi
else
    if command -v terminal-notifier
    then
        eval "terminal-notifier -message \"$@\""
    elif command -v notify-send &> /dev/null
    then
        notify-send $@
    else
        echo $@
    fi
fi
