#!/bin/sh

# This is the postinst deb package script. It runs after the package contents are installed.

set -e

if [ -d /etc/dockwatch ]; then
  chown -R abc: /etc/dockwatch
fi

if [ -d /var/log/mulery ]; then
  chown -R abc: /var/log/mulery
fi

if [ -f /etc/mulery/docker-compose.yml ] && [ -f /etc/mulery/mulery.conf ]; then
    echo "Running 'docker-compose up -d' in /etc/mulery"
    cd /etc/mulery && \
    docker-compose up -d
fi
