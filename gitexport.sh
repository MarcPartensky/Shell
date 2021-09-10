#!/usr/bin/env zsh

# TMP_FILE="/tmp/gitremotes.txt"
TMP_FOLDER="/tmp/gitremotes"
TMP_ZIPPED="/tmp/gitremotes.tar.gz"
if (( $# > 0 )); then
	GIT_PROJECTS=$1
else
	GIT_PROJECTS=$(pwd)
fi

# for gitproject in $(/bin/ls); do
# 	if [[ -d $gitproject/.git ]]; then
# 		git -C $gitproject remote -v | head -n 1 | awk '{print $2}'
# 	fi
# done

mkdir $TMP_FOLDER

for git_project in $(find $GIT_PROJECTS); do
	if [[ -d $git_project/.git ]]; then
		mkdir $TMP_FOLDER/$git_project
		cp $git_project/.git/config $TMP_FOLDER/$git_project/.git/config
	fi
done

echo $GIT_PROJECTS
