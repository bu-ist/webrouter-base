#!/bin/bash -x
# 
# Build a new version of the image
#
version="$(cat BUILDDATE.DAT)"
docker build -t "dsmk/web-router-base:$version" .
# now we test it out
docker run "dsmk/web-router-base:$version" /usr/sbin/run-nginx.sh -t 
