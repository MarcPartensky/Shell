#!/bin/sh

for gitproject in `/bin/ls $PROGRAMS_PATH`
do
    for remote in $(git -C $PROGRAMS_PATH/$gitproject remote -v | awk '{print $2}')
    do
        git -C $PROGRAMS_PATH submodule set-url $gitproject $remote
    done
done
