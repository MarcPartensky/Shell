#!/bin/bash
# Wake up remote machine
# Usage: $0 mac_adress ip_adress
 
# Check interval
SLEEPTIME=60
# Temp directory where to store a file to indicate that the computer was already turn on (used for shutdow)
TEMP_DIRECTORY=/$HOME/tmp
# Number of retries
RETRY=20
 
die () {
 echo >&2 "$@"
 exit 1
}
 
[ "$#" -eq 2 ] || die "Usage : $0 Mac_adress IP_adress"
HOST_MAC=$1
HOST_IP=$2
 
[ -d $directory ] || mkdir $directory
 
ping -c 2 -w 15 $HOST_IP > /dev/null
RESULT=$?
if [ $RESULT -eq 0 ]; then
 echo "Host $HOST_IP is already up - exiting"
 touch $TEMP_DIRECTORY/$HOST_IP
 exit 0
else  
 echo "Trying to wake up $HOST_IP"
 TEST_NUMBER=0
 while [ $RESULT -ne 0 ]; do
  TEST_NUMBER=`expr $TEST_NUMBER + 1`
  echo "Test #$TEST_NUMBER)"
  wakeonlan $HOST_MAC
  sleep $SLEEPTIME
  ping -c 2 -w 15 $HOST_IP > /dev/null
  RESULT=$?
  if [ $RESULT -ne 0 ] && [ $TEST_NUMBER -eq $RETRY ]; then
   echo "$RETRY retry unsuccessful - leave"
   exit 1
  fi
 done
fi