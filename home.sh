#!/bin/sh

# My attempt to feel like home everywhere I go.

# install docker
curl https://raw.githubusercontent.com/MarcPartensky/Shell/master/install-docker.sh | sh
docker run -it --mount /:/ -P marcpartensky/env
