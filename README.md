# nerdzeu/docker-php

This repo is part of the docker enviroment for nerdz (`nerdzeu/docker`).

It contains the php-fpm configuration and expose its port (9000).

It exposes the container `/var/www/html` folder as a volume.

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
