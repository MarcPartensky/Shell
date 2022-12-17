#!/bin/sh
folder=~/git

for project in $folder/*/
do
    if git -C $project remote -v | tr '[A-Z]' '[a-z]' | grep marcpartensky > /dev/null
    then
        mkdir -p $project/.github
        cp $folder/template/.github/FUNDING.yml $project/.github/FUNDING.yml
        echo  $project
    fi
done
