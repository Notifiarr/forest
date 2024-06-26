#!/bin/bash

# This is the prerm deb package script. It runs before the package is removed.

if [ "$1" = "upgrade" ] || [ "$1" = "1" ] ; then
  exit 0
fi

if [ -f /home/abc/docker-compose.yml ]; then
  cd /home/abc && \
  docker-compose down
fi

if [ -f /home/abc/dockwatch/logins ]; then
  echo > /home/abc/dockwatch/logins
fi
