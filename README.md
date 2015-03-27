# nerdzeu/docker-php

This repo is part of the docker enviroment for nerdz (`nerdzeu/docker`).

It contains the php-fpm configuration and expose its port (9000).

It exposes the container `/srv/http` folder as a volume.

The `startup.sh` fetch the `nerdzeu/nerdz.eu` repo and its submodules.

The `conf` directory contains the php and php-fpm configuration files. The `conf/config.php` files is a sample configuration file to move in `env/nerdz.eu/class/config/index.php` if you want a running 

# Usage

Use it as part of nerdzeu/docker.

If you want to pull and run the image you can do it in the classical docker way:

```sh
docker pull nerdzeu/docker-php
docker run nerdzeu/docker-php
```

If you want to build the image:

```sh
docker build -t <name> .
```
