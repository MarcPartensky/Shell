#!/bin/sh

script=$1
if [ -x $1 ]; then
    cmd=$(echo $script | rev | cut -d'.' -f2- | rev | sed 's/\.\///')
    # ln -sf $PWD/$script ~/.local/bin/$cmd
    echo -e "Loaded \e[1m$script\e[0m as \e[1m$cmd\e[0m"
else
    echo -e "\e[1m$script\e[0m is not executable."
fi
