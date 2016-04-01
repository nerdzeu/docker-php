FROM base/archlinux
MAINTAINER Paolo Galeone <nessuno@nerdz.eu>

RUN sed -i -e 's#https://mirrors\.kernel\.org#http://mirror.clibre.uqam.ca#g' /etc/pacman.d/mirrorlist && \
       pacman -Sy haveged openssl ca-certificates archlinux-keyring --noconfirm && haveged -w 1024 -v 1 && \
       pacman-key --init && pacman-key --populate archlinux && \
       pacman -Syu php \
       php-pgsql \
       php-gd \
       php-fpm \
       php-composer \
       php-apcu-bc \
       wget \
       postgresql \
       git nodejs npm gcc-libs \
       pam shadow sudo --noconfirm
RUN npm install uglify-js -g

EXPOSE 9000

VOLUME /srv/http

RUN useradd -d /srv/http/ -s /bin/bash php && chown -R php:php /srv/http/
RUN mkdir -p /etc/pki/tls/certs && cp /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt

RUN echo "php ALL = NOPASSWD: /opt/docker_owner.sh" >> /etc/sudoers

COPY startup.sh /opt/
COPY docker_owner.sh /opt/
RUN chown php:php /opt/docker_owner.sh && chmod +x /opt/docker_owner.sh

USER php
ENTRYPOINT bash /opt/startup.sh
