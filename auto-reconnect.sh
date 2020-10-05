#!/bin/bash
if [ $(networksetup -getinfo Wi-Fi | grep -c 'IP address:') = '1' ]
then networksetup -setairportnetwork en1 'ISEP ELEVES EAP' 'test' 
fi
