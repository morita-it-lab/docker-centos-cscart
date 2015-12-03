#
# CentOS7
# + httpd
# + php
#
# https://github.com/CentOS/CentOS-Dockerfiles/tree/master/httpd/centos7
#
FROM centos:7
MAINTAINER MASASHI MORITA <morita@mrita-it-lab.jp>

# ----- Update yum
RUN yum -y update
RUN yum -y install httpd

# ----- Common utilities
RUN yum -y install vim
RUN yum -y install unzip
RUN yum -y install wget
RUN yum -y install gcc
RUN yum -y install make
RUN yum -y install expect

# php v5.6
RUN yum -y install epel-release
RUN cd /etc/yum.repos.d
RUN wget http://rpms.famillecollet.com/enterprise/remi.repo
RUN yum -y --enablerepo=remi,remi-php56 install php php-common php-devel php-pear

# mysql
RUN yum -y --enablerepo=remi,remi-php56 install php-mysql

# imagick
RUN yum -y install ImageMagick
RUN yum -y install ImageMagick-devel
ADD expect_pecl_install_imagick.txt /expect_pecl_install_imagick.txt
RUN expect /expect_pecl_install_imagick.txt
RUN echo "extension=imagick.so" > /etc/php.d/imagick.ini

# ----- Clean yum
RUN yum clean all

VOLUME /var/www/html
WORKDIR /var/www/html

# default php
RUN echo "<?php phpinfo(); ?>" > /var/www/html/index.php

# ----- httpd settings
ADD docroot.conf /etc/httpd/conf.d/docroot.conf

# ----- vim settings
ADD vimrc.txt /root/.vimrc

# http port
EXPOSE 80
# https port
EXPOSE 443

ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]
