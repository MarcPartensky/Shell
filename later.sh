#!/usr/bin/env zsh

# Do some command and comeback later.
name=`echo $1-$RANDOM`
cmd=$@
description="$name : $cmd"

n "Started $description"
# abduco -n $name $SHELL -c "$SHELL -c '$cmd && n Finished $name'" &
screen -dmS $name $SHELL -c "$cmd && n \"Finished $description\" && $SHELL"
