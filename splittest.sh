#!/bin/bash

# separator is comma
VAR=$1
IFS=":" read -r ONE TWO<<< "${VAR}"
echo "${ONE} ${TWO}"
echo "${ONE} ${TWO}"
