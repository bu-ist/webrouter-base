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
NAMESERVER=`/bin/grep ^nameserver /etc/resolv.conf | /bin/awk '{print $2}' | head -1 `
export NAMESERVER

# update the cloudfront_ips.conf file used for getting the client IP when using cloudfront
mkdir -p /tmp/run-nginx
TMPDIR=/tmp/run-nginx /usr/sbin/get-cloudfront-ip.rb >/etc/nginx/cloudfront_ips.conf

# generate self-signed SSL certificates if they do not actually exist
if [ ! -f /etc/pki/nginx/cert.key ]; then
  set -x 
  cd /etc/pki/nginx
  openssl req -x509 -newkey rsa:4096 -keyout cert.key -out cert.pem -days 365 -nodes -subj "/C=US/ST=Massachusetts/L=Boston/O=Boston University/CN=internal-${LANDSCAPE}.domain"
  set +x
  ls -l /etc/pki/nginx
fi

# this is where we would load the first map files
# look through the common configuration files and run erb to 
FILES="nginx.conf conf.d/map-def.conf conf.d/ssl.conf conf.d/default.conf default.d/www.conf"

for file in $FILES ; do
  fullfile="/etc/nginx/$file"
  erbfile="/etc/erb/nginx/${file}.erb"
  if [ -e "${erbfile}" ]; then
    echo "erb substitutions for $fullfile"
    /usr/bin/erb "${erbfile}" >$fullfile
  fi
done

echo "Starting nginx"
exec /usr/sbin/nginx 
