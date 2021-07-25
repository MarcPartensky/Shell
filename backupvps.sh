#!/usr/bin/env zsh

export BACKUPVPS_LOG="/var/log/backupvps.log"

ssh vps mkdir -p /tmp/sr/
ssh tower mkdir -p /home/marc/vpsbackups
ssh vps ls /srv > /tmp/vps_srv.txt
timestamp=$(date +"%Y-%m-%d_%H:%M:%S")
echo "timestamp: $timestamp" >& $BACKUPVPS_LOG
ssh vps rm -rf /tmp/srv/* >& $BACKUPVPS_LOG

for f in $(cat /tmp/vps_srv.txt); do
	echo "Processing $f" >& $BACKUPVPS_LOG
	echo "Zipping $f" >& $BACKUPVPS_LOG
	ssh vps tar cvzf /tmp/srv/${f}_$timestamp.tar.gz /srv/$f >& $BACKUPVPS_LOG
	echo "Zipped $f" >& $BACKUPVPS_LOG
	echo "Transfering $f" >& $BACKUPVPS_LOG
	scp vps:/tmp/srv/${f}_$timestamp.tar.gz tower:/home/marc/vpsbackups/${f}_$timestamp.tar.gz >& $BACKUPVPS_LOG
	echo "Transfered $f" >& $BACKUPVPS_LOG
	ssh vps rm -rf /tmp/srv/${f}_$timestamp.tar.gz >& $BACKUPVPS_LOG
	echo "Processed $f\n" >& $BACKUPVPS_LOG
done

echo "Backed up: $(cat /tmp/vps_srv.txt)" >& $BACKUPVPS_LOG
