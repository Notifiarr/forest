#!/bin/sh

# This is the preinst deb package script. It runs before the package is installed.

set -e

# Make a user and group for this app, but only if it does not already exist.
groupadd --force --non-unique --gid 1003 abc
id abc >/dev/null 2>&1 || \
  useradd --non-unique --create-home --uid 1003 --gid 1003 --groups users,docker abc
usermod -aG docker abc
