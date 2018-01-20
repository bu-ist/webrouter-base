FROM docker.io/nginx

RUN apt-get update && apt-get install openssl

ADD default.conf /etc/nginx/conf.d/default.conf
ADD mock.conf /etc/nginx/mock.conf
COPY html/ /usr/share/nginx/html/

ADD run-nginx.sh /usr/sbin/run-nginx.sh
CMD /usr/sbin/run-nginx.sh

#
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
  && mkdir -p /etc/pki/nginx \
  && chmod 755 /usr/sbin/run-nginx.sh

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


