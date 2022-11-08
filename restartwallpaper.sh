#!/usr/bin/env zsh

if systemctl --user is-active wpaperd
then
    systemctl --user restart wpaperd
elif systemctl --user is-active swww
then
    systemctl --user restart swww
else
    n Neither wpaperd of swww are actives
fi
