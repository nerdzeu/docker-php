FROM base/archlinux
MAINTAINER Paolo Galeone <nessuno@nerdz.eu>

RUN sed -i -e 's#https://mirrors\.kernel\.org#http://mirror.clibre.uqam.ca#g' /etc/pacman.d/mirrorlist && \
       pacman -Sy haveged ca-certificates archlinux-keyring --noconfirm && haveged -w 1024 -v 1 && \
       pacman-key --init && pacman-key --populate archlinux && \
       pacman -S php \
       php-pgsql \
       php-pear \
       php-gd \
       php-fpm \
       php-composer \
       php-apcu \
       wget \
       postgresql \
       git nodejs npm --noconfirm
RUN npm install uglify-js -g

EXPOSE 9000

VOLUME /srv/http

COPY startup.sh /opt/

ENTRYPOINT bash /opt/startup.sh
