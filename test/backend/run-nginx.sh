#!/bin/sh -x
#
# Run this script to generate the nginx.conf from nginx.conf.erb
#
if [ "x$LANDSCAPE" = "x" ]; then
  LANDSCAPE="test"
  export LANDSCAPE
fi

# get common variables from the vars.sh 
#
if [ -f /etc/nginx/vars.sh ]; then
  . /etc/nginx/vars.sh
fi

# get a nameserver from the system for nginx resolver lines
#NAMESERVER=`/bin/grep ^nameserver /etc/resolv.conf | /bin/awk '{print $2}' | head -1 `
#export NAMESERVER

# generate self-signed SSL certificates if they do not actually exist
if [ ! -f /etc/pki/nginx/cert.key ]; then
  set -x 
  cd /etc/pki/nginx
  openssl req -x509 -newkey rsa:4096 -keyout cert.key -out cert.pem -days 365 -nodes -subj "/C=US/ST=Massachusetts/L=Boston/O=Boston University/CN=internal-${LANDSCAPE}.domain"
  set +x
  ls -l /etc/pki/nginx
fi

echo "Starting nginx"
exec /usr/sbin/nginx 
