#!/usr/bin/env sh

invasiveroutes1=$(ip route | grep 0.0.0.0/1)
invasiveroutes2=$(ip route | grep 128.0.0.0/1)

invasiveroutes=( "${invasiveroutes1[@]}" "${invasiveroutes2[@]}" )
echo ${invasiveroutes[@]}
