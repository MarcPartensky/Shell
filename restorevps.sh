#!/bin/sh

ssh tower ls  /srv/*07-25_15:51:20* | xargs -I {} scp ./{} vps:/srv
