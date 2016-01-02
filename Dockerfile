FROM base/archlinux
MAINTAINER Paolo Galeone <nessuno@nerdz.eu>

RUN sed -i -e 's#https://mirrors\.kernel\.org#http://mirror.clibre.uqam.ca#g' /etc/pacman.d/mirrorlist && \
       pacman -Sy haveged openssl ca-certificates archlinux-keyring --noconfirm && haveged -w 1024 -v 1 && \
       pacman-key --init && pacman-key --populate archlinux && \
       pacman -S php \
       php-pgsql \
       php-gd \
       php-fpm \
       php-composer \
       php-apcu-bc \
       wget \
       postgresql \
       git nodejs npm --noconfirm
RUN npm install uglify-js -g

EXPOSE 9000

VOLUME /srv/http

COPY startup.sh /opt/

ENTRYPOINT bash /opt/startup.sh
