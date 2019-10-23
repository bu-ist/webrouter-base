#!/bin/bash -x
# 
# Build a new version of the image
#
version="$(cat BUILDDATE.DAT)"
image="buist/websites-webrouter-base"
fullimage="$image:$version"

docker build -t "$fullimage" .
# now we test it out
# Old simple test
#if docker run "$fullimage" /usr/sbin/run-nginx.sh -t ; then
# Better current test
docker tag "$fullimage" "validate-router"
if /usr/local/bin/docker-compose -f validate.yml up --abort-on-container-exit ; then
  # if it tests out then push to docker hub
  #docker push "$fullimage"
  echo "built successfully"
else
  echo "errors testing built image"
fi

#

