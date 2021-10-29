#!/bin/sh

LOG_FOLDER="/var/log"
[ -d $LOG_FOLDER ] || echo Creating log folder && mkdir -p /var/log

if command -v brew; then
	$(brew upgrade -f &&
		brew autoremove &&
		brew cleanup) | tee $LOG_FOLDER/update_brew.log >&1 &&
		n Brew update done &
fi
