#!/usr/bin/env bash
if [ ! -d /srv/http/nerdz.eu ]; then
    cd /srv/http
    git clone --recursive https://github.com/nerdzeu/nerdz.eu.git
    cd nerdz.eu
    composer install
    cp /srv/http/test-db-config.php /srv/http/nerdz.eu/class/config/index.php 
fi

chown -R http:http /srv/http
/usr/bin/php-fpm -F
