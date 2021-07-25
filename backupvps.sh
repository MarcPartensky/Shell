#!/usr/bin/env zsh

ssh vps mkdir -p /tmp/srv
ssh tower mkdir -p /home/marc/vpsbackups
ssh vps ls /srv > /tmp/vps_srv.txt
timestamp=$(date +"%Y-%m-%d_%H:%M:%S")
echo "timestamp: $timestamp"
ssh vps rm -rf /tmp/srv/*

for f in $(cat /tmp/vps_srv.txt); do
	echo "Processing $f"
	echo "Zipping $f"
	ssh vps tar cvzf /tmp/srv/${f}_$timestamp.tar.gz /srv/$f
	echo "Zipped $f"
	echo "Transfering $f"
	scp -v vps:/tmp/srv/${f}_$timestamp.tar.gz tower:/home/marc/vpsbackups/${f}_$timestamp.tar.gz
	echo "Transfered $f"
	ssh vps rm -rf /tmp/srv/${f}_$timestamp.tar.gz
	echo "Processed $f\n"
done

echo "Backed up: $(cat /tmp/vps_srv.txt)"
