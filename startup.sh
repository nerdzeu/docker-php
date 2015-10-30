#!/usr/bin/env bash
if [ ! -d /srv/http/nerdz.eu ]; then
    cd /srv/http
    git clone --recursive https://github.com/nerdzeu/nerdz.eu.git
    cd nerdz.eu
    composer install
    mkdir /srv/http/nerdz.eu/class/config/
    cat << \EOF > /srv/http/nerdz.eu/class/config/index.php
<?php
namespace NERDZ\Core\Config;

define('DEBUG', 1);

class Variables
{
    public static $data = [
        'POSTGRESQL_HOST'        => 'postgres',
        'POSTGRESQL_PORT'        => '5432',
        'POSTGRESQL_DATA_NAME'   => 'test_db',
        'POSTGRESQL_USER'        => 'test_db',
        'POSTGRESQL_PASS'        => 'db_test',
        'MIN_LENGTH_USER'        => 2,
        'MIN_LENGTH_PASS'        => 6,
        'MIN_LENGTH_NAME'        => 2,
        'MIN_LENGTH_SURNAME'     => 2,
        'CAPTCHA_LEVEL'          => 5,
        'SMTP_SERVER'            => 'smtp.gmail.com',
        'SMTP_PORT'              => '587',
        'SMTP_USER'              => 'WILLNOWORK',
        'SMTP_PASS'              => 'WILLNOTWORK',
        'SITE_NAME'              => 'NERD(Z)OCKER',
        'SITE_HOST'              => 'docker.nerdz.eu',
        'STATIC_DOMAIN'          => 'static.docker.nerdz.eu',
        'MOBILE_HOST'            => 'mobile.docker.nerdz.eu',
        'MINIFICATION_ENABLED'   => true,
        'REDIS_HOST'             => '',
        'REDIS_PORT'             => '',
        'ISSUE_GIT_KEY'          => 'WILLNOWORK',
        'PUSHED_ENABLED'         => false,
        'PUSHED_IP6'             => true,
        'PUSHED_PORT'            => 5667,
        'CAMO_KEY'               => '',
        'MEDIA_HOST'             => 'media.docker.nerdz.eu',
        'LOGIN_SSL_ONLY'         => false,
        'HTTPS_DOMAIN'           => 'docker.nerdz.eu'
    ];
}
EOF
    cd ..
    git clone https://github.com/nerdzeu/nerdz-test-db.git
    cd nerdz-test-db
    ./initdb.sh postgres test_db db_test postgres 5432
fi

chown -R http:http /srv/http
/usr/bin/php-fpm -F
