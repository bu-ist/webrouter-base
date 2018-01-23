FROM amazonlinux:latest

ENV PATCHDATE 20170712
RUN yum -y update && yum clean all

#RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

#RUN yum -y install --setopt=tsflags=nodocs epel-release && yum clean all

RUN yum install -y nginx ruby && yum clean all

ADD files/run-nginx.sh /usr/sbin/run-nginx.sh
ADD files/get-cloudfront-ip.rb /usr/sbin/get-cloudfront-ip.rb

RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
  && chmod 755 /usr/sbin/run-nginx.sh /usr/sbin/get-cloudfront-ip.rb \
  && mkdir -p /etc/erb/nginx/conf.d /etc/erb/nginx/default.d \
  && ln -sf /dev/stderr /var/log/nginx/error.log \
  && ln -sf /dev/stdout /var/log/nginx/access.log 

EXPOSE 80 443

VOLUME [ "/var/log/nginx", "/etc/pki/nginx" ]
# these are so we can run nginx read-only
VOLUME [ "/var/lib/nginx", "/tmp", "/var/run", "/var/log/nginx", "/etc/nginx" ]

CMD /usr/sbin/run-nginx.sh

# everything before this should be split into a base configuration for all landscapes.
# Everything after this should remain in this repo and be autobuilt by CodePipeline.

# the following configs should remain down here if we want to pre-generate them and make the configuration
# directory fully read-only.  They should go above the line if we want to ensure they do not change between
# landscapes (and keep variable substituting them on each invocation.
#
ADD files/nginx.conf.erb /etc/erb/nginx/nginx.conf.erb
ADD files/conf.d-map-def.conf.erb /etc/erb/nginx/conf.d/map-def.conf.erb
ADD files/conf.d-ssl.conf.erb /etc/erb/nginx/conf.d/ssl.conf.erb
ADD files/conf.d-default.conf.erb /etc/erb/nginx/conf.d/default.conf.erb
ADD files/default.d-www.conf.erb /etc/erb/nginx/default.d/www.conf.erb

# the default map configuration is for internal testing
ADD files/sites.map /etc/nginx/sites.map
ADD files/hosts.map.erb /etc/erb/nginx/hosts.map.erb
ADD files/redirects.map.erb /etc/erb/nginx/redirects.map.erb
ADD files/vars.sh /etc/nginx/vars.sh

# for now this is our split and everything below this is for a different location
#
# the final default landscape should be test
#ARG landscape=syst

# These files remains in the landscape specific CodePipeline area.
#ADD landscape/${landscape}/sites.map /etc/nginx/sites.map
#ADD landscape/${landscape}/vars.sh /etc/nginx/vars.sh

