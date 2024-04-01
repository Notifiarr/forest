#!/bin/sh

# This is the postinst deb package script. It runs after the package contents are installed.

set -e

# Give dockwatch a login password.
if grep -q DN_API_KEY /etc/default/notifiarr 2>/dev/null; then
  echo admin:$(grep DN_API_KEY /etc/default/notifiarr | cut -d= -f2) > /home/abc/dockwatch/logins
fi

if [ -d /home/abc ]; then
  chown -R abc: /home/abc
fi

if [ -d /var/log/mulery ]; then
  chown -R abc: /var/log/mulery
fi

if [ -f /home/abc/mulery/mulery.conf ]; then
    echo "Running 'docker-compose up -d' in /home/abc/"
    cd /home/abc && \
    docker-compose up -d
fi
