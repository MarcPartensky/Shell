#!/bin/sh

systemctl start --user wssh
ssh wstunnel
systemctl stop --user wssh
