FROM base/archlinux
MAINTAINER Paolo Galeone <nessuno@nerdz.eu>

RUN sed -i -e 's#https://mirrors\.kernel\.org#http://mirror.clibre.uqam.ca#g' /etc/pacman.d/mirrorlist && \
       pacman -Sy haveged archlinux-keyring --noconfirm && haveged -w 1024 -v 1 && \
       pacman-key --init && pacman-key --populate archlinux && \
       pacman -S php \
       php-pgsql \
       php-pear \
       php-gd \
       php-fpm \
       php-composer \
       php-apcu \
       wget \
       git nodejs npm --noconfirm
RUN npm install uglify-js -g

COPY conf/php-fpm.conf /etc/php/
COPY conf/php.ini /etc/php/
RUN echo "extension=apcu.so" >  /etc/php/conf.d/apcu.ini

EXPOSE 9000

VOLUME /srv/http

COPY startup.sh /opt/

ENTRYPOINT bash /opt/startup.sh
