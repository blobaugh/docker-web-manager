# Docker Web Manager

Tool to simplify the management of web container in Docker.

## Setup

1. Create the `web` network by running the command ./bin/create-network.sh 
1. Run `docker-compose up -d`

## How it works

This is based on the `jwilder/nginx-proxy` Nginx proxy docker container, which will automatically proxy traffic when new containers come online. The container will watch the `VIRTUAL_HOST` environment variable on containers and proxy traffic from the domain specified in the variables value to the container. This also supports SSL with letsencrypt automagically. For SSL set the LETSENCRYPT_HOST and LETSENCRYPT_EMAIL environment variables.

```
VIRTUAL_HOST=example.com
LETSENCRYPT_HOST=example.com
LETSENCRYPT_EMAIL=web@example.com
```

### Example website with docker-compose.yml

Here is an example docker-compose.yml that will get a site working quickly with the nginx proxy.

```
version: '2'

services:
  whoami:
    image: jwilder/whoami
    environment:
      - VIRTUAL_HOST=example.com
      - LETSENCRYPT_HOST=example.com
      - LETSENCRYPT_EMAIL=web@example.com

networks:
  default:
    external:
      name: web
  web:
    external: true
```

## Troubleshooting

### DNS does not resolve

Web browsers tend to aggressively cache DNS info. If you are getting a message that the domain cannot resolve, but the container is running, try flushing the DNS cache.

On Mac: `sudo killall -HUP mDNSResponder`

## Changelog