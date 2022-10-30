#!/usr/bin/env zsh

# Do some command and comeback later.
# name="$1-$RANDOM"
name=$1
cmd=$@
description="$name : $cmd"

n "Started $description"
# abduco -n $name $SHELL -c "$SHELL -c '$cmd && n Finished $name'" &
screen -dmS $name $SHELL -c "$cmd && n \"Finished $description\" && $SHELL"
