#!/usr/bin/env bash
set -euo pipefail

# Nettoyage idempotent
docker rm -f script http 2>/dev/null || true

# PHP-FPM (SCRIPT)
docker run -d --name script \
  --network tp3net \
  -v "$(pwd)/src:/app" \
  php:8.2-fpm

# Nginx (HTTP)
docker run -d --name http \
  --network tp3net \
  -p 8080:80 \
  -v "$(pwd)/src:/app" \
  -v "/tmp/default.conf:/etc/nginx/conf.d/default.conf" \
  nginx:alpine






