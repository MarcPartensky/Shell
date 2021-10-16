#!/usr/bin/env zsh

export HIDRIVE_BACKUP_PATH="/mnt/dav/users/marcpartensky/backups"

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
echo "timestamp: $timestamp"
mkdir "$HIDRIVE_BACKUP_PATH/${timestamp}"
# echo "$HIDRIVE_BACKUP_PATH/${timestamp}"

for f in $(/bin/ls /srv); do
	echo "Processing $f"
	echo "Zipping $f"
	tar cvzf $HIDRIVE_BACKUP_PATH/${timestamp}/${f}.tar.gz /srv/${f}
	echo "Processed $f\n"
done

echo "Backed up: $(cat /tmp/vps_srv.txt)"
