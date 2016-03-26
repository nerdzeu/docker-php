#!/usr/bin/env bash
if [ ! -d /srv/http/nerdz.eu ]; then
    cd /srv/http
    git clone --recursive https://github.com/nerdzeu/nerdz.eu.git
    cd nerdz.eu
    composer install
    mkdir /srv/http/nerdz.eu/class/config/
    cat << \EOF > /srv/http/nerdz.eu/class/config/Variables.class.php
<?php
namespace NERDZ\Core\Config;

class Variables
{
    public static $data = [
        // Do not change unless you know what are you doing
        'POSTGRESQL_HOST'        => 'postgres',
        'POSTGRESQL_PORT'        => '5432',
        'POSTGRESQL_DATA_NAME'   => 'test_db',
        'POSTGRESQL_USER'        => 'test_db',
        'POSTGRESQL_PASS'        => 'db_test',
        // Free configuration
        'MIN_LENGTH_USER'        => 2,
        'MIN_LENGTH_PASS'        => 6,
        'MIN_LENGTH_NAME'        => 2,
        'MIN_LENGTH_SURNAME'     => 2,
        'CAPTCHA_LEVEL'          => 5,
        // Configure your SMTP server
        'SMTP_SERVER'            => 'smtp.gmail.com',
        'SMTP_PORT'              => '587',
        'SMTP_USER'              => 'WILLNOWORK',
        'SMTP_PASS'              => 'WILLNOTWORK',
        // Configure the name and ther REAL host (the address typed in the
        // address bar, outside the docker env)
        'SITE_NAME'              => 'NERD(Z)OCKER',
        'SITE_HOST'              => '',
        'STATIC_DOMAIN'          => '',
        'MOBILE_HOST'            => '',
        // Configure minification
        'MINIFICATION_ENABLED'   => true,
        // Use redis to store session variables if you ant
        'REDIS_HOST'             => '',
        'REDIS_PORT'             => '',
        // Put here the github key to the bug board
        'ISSUE_GIT_KEY'          => 'WILLNOWORK',
        // Configure the pushed daemon if you have it
        'PUSHED_ENABLED'         => false,
        'PUSHED_IP6'             => true,
        'PUSHED_PORT'            => 5667,
        // Configure camo
        'CAMO_KEY'               => '',
        // Set the media host
        'MEDIA_HOST'             => '',
        // Configure https
        'LOGIN_SSL_ONLY'         => false,
        'HTTPS_DOMAIN'           => '',
EOF
    PROXY=$(ip route | awk '{print $1}' |grep -v default)
    cat << EOF >> /srv/http/nerdz.eu/class/config/Variables.class.php
        'TRUSTED_PROXIES'        => ['$PROXY']
    ];
}
EOF
    cd ..
    git clone https://github.com/nerdzeu/nerdz-test-db.git
    cd nerdz-test-db
    ./initdb.sh postgres test_db db_test postgres 5432
fi

/usr/bin/php-fpm -F
