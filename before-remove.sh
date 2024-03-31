#!/bin/bash

# This is the prerm deb package script. It runs before the package is removed.

if [ "$1" = "upgrade" ] || [ "$1" = "1" ] ; then
  exit 0
fi

if [ -f /etc/mulery/docker-compose.yml ]; then
  cd /etc/mulery && \
  docker-compose down
fi
