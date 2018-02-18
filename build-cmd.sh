#!/bin/bash -x
# 
# Build a new version of the image
#
version="$(cat BUILDDATE.DAT)"
image="buist/websites-webrouter-base"
fullimage="$image:$version"

docker build -t "$fullimage" .
# now we test it out
if docker run "$fullimage" /usr/sbin/run-nginx.sh -t ; then
  # if it tests out then push to docker hub
  docker push "$fullimage"
else
  echo "errors testing built image"
fi

#

