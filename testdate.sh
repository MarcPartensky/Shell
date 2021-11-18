#!/bin/sh

echo `$(date +%Y%m%d-%H%M%S).$(git log -1 --pretty=%h)`
