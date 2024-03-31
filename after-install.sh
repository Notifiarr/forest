#!/bin/sh

# This is the postinst deb package script. It runs after the package contents are installed.

set -e

if [ -d /etc/dockwatch ]; then
  chown -R abc:root /etc/dockwatch
fi