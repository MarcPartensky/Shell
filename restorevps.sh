#!/bin/sh

echo "Restoration starting!"
timestamp=$1
towerpath="/media/ssd1/Marc/backups"
vpspath="/srv"
tmpfile="/tmp/vps_srv.txt"

ssh tower ls $towerpath/*$timestamp* > $tmpfile
echo "Transfering files"
cat $tmpfile | xargs -I {} scp /{} vps:$vpspath/{}
echo "Transfered files successfully"
echo "Uncompressing files"
ssh vps rename 's/_2021-07-25_15:51:20//' $vpspath/*.tar.gz
ssh vps ls $vpspath > $tmpfile
cat $tmpfile | xargs -I {} ssh vps tar xvzf $vpspath/{}
echo "Uncompressed files"
echo "Removing compressed files"
cat $tmpfile | xargs -I {} rm $vpspath/{}
echot "Removed compressed files"
rm $tmpfile
echo "Restoration complete!"
