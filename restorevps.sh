#!/usr/bin/env zsh

echo "Restoration starting!"
# timestamp=$1
timestamp="2021-07-25_15:51:20"
towerpath="/media/ssd1/Marc/backups"
vpspath="/srv"
tmpfile="/tmp/vps_srv.txt"

echo "timestamp: $timestamp"
echo "towerpath: $towerpath"
echo "vpspath: $vpspath"
echo "tmpfile: $tmpfile"

ssh tower ls -w 1 $towerpath | grep "$timestamp" > $tmpfile
cat $tmpfile
echo "Transfering files"
# cat $tmpfile | xargs -I {} du -h tower:$towerpath/{}
for f in $(cat $tmpfile); do
	# echo "Transfering tower:$towerpath/$f"
	# echo $f
	echo "tower:/media/ssd1/Marc/backups/${f} vps:/srv"
	scp tower:/media/ssd1/Marc/backups/${f} vps:/srv
	# echo "Transfred $f"
done
echo "Transfered files successfully"
# echo "Uncompressing files"
ssh vps rename "s/_$timestamp//" $vpspath/*.tar.gz
# ssh vps ls $vpspath > $tmpfile
# cat $tmpfile | xargs -I {} ssh vps tar xvzf $vpspath/{}
# echo "Uncompressed files"
# echo "Removing compressed files"
# cat $tmpfile | xargs -I {} rm $vpspath/{}
# echot "Removed compressed files"
# rm $tmpfile
# echo "Restoration complete!"
