#FROM amazonlinux:2
#FROM centos:7
FROM ubuntu

ENV build  1

RUN apt update && apt install -y git bats curl
# RUN yum -y install epel-release git && yum clean all
# RUN ls -l /etc/yum.repos.d/
# RUN cat /etc/yum.repos.d/epel.repo
# RUN yum search bats
# RUN yum -y install --enablerepo=epel bats && yum clean all

COPY *.sh ./
COPY tests/ ./tests/

ENV CONNECT bufe-autotest-test
ENV LANDSCAPE test
# ENV TEST_BASE 1
CMD ["./test_bats.sh" ]

#CMD ["./test_app.sh", "-j", "test", "bufe-autotest-test"]
