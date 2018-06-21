FROM httpd:2.4-alpine

COPY httpd.conf /usr/local/apache2/conf/
COPY httpd-mock.conf /usr/local/apache2/conf/extra/httpd-mock.conf

#RUN apt-get update && apt-get install openssl

RUN apk --no-cache add perl-cgi

COPY html/ /usr/local/apache2/htdocs/
COPY cgi-bin/ /usr/local/apache2/cgi-bin/

# ssl setup
COPY httpd-ssl.conf /usr/local/apache2/conf/extra/
COPY cert.pem /usr/local/apache2/conf/server.crt
COPY cert.key /usr/local/apache2/conf/server.key

RUN chmod 755 /usr/local/apache2/cgi-bin/*

#
#RUN mkdir -p /etc/pki/nginx \
#  && chmod 755 /usr/sbin/run-nginx.sh

EXPOSE 80
EXPOSE 443

#VOLUME /var/log/nginx
#VOLUME /etc/pki/nginx
#
#ADD nginx.conf.erb /etc/nginx/nginx.conf.erb
#ADD conf.d-map-def.conf.erb /etc/nginx/conf.d/map-def.conf.erb
#ADD conf.d-ssl.conf.erb /etc/nginx/conf.d/ssl.conf.erb
#ADD conf.d-default.conf.erb /etc/nginx/conf.d/default.conf.erb
#ADD default.d-www.conf.erb /etc/nginx/default.d/www.conf.erb
#ADD sites.map /etc/nginx/sites.map


