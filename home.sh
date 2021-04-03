#!/bin/sh

# My attempt to feel like home everywhere I go.

# install docker with script no matter the os
curl https://raw.githubusercontent.com/MarcPartensky/Shell/master/install-docker.sh | sh

# install docker
docker run -it -v /:/ -P marcpartensky/env
