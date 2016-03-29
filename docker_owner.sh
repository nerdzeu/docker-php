#!/usr/bin/env bash

chgrp -R $(cat /srv/http/DOCKER_GROUP) "$1"
chmod u+rwxs "$1"
chmod g+rwxs "$1"
chmod -R 0775 "$1"
