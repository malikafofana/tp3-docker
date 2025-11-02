#!/usr/bin/env bash
set -euo pipefail

# Nettoyage
docker rm -f http script data 2>/dev/null || true

# (Re)création réseau si besoin
docker network inspect tp3net >/dev/null 2>&1 || docker network create tp3net

# DATA (MariaDB) - init auto via /docker-entrypoint-initdb.d
docker run -d --name data \
  --network tp3net \
  -e MARIADB_RANDOM_ROOT_PASSWORD=yes \
  -v "$(pwd)/db-init:/docker-entrypoint-initdb.d" \
  mariadb:latest

# SCRIPT (PHP-FPM avec mysqli)
docker build -t php-fpm-mysqli:etape2 .
docker run -d --name script \
  --network tp3net \
  -v "$(pwd)/src:/app" \
  php-fpm-mysqli:etape2

# HTTP (Nginx)
docker run -d --name http \
  --network tp3net \
  -p 8080:80 \
  -v "$(pwd)/src:/app" \
  -v "$(pwd)/config/default.conf:/etc/nginx/conf.d/default.conf" \
  nginx:alpine
