#!/bin/bash

# This is the entry point for setting up a mulery tunnel. Download and run this script on a fresh Ubuntu 22.04 server.
# Be prepared to provide the notifiarr-bot api key. You should also have an account on carolina.notifiarr.com already.

if ! grep -q DN_API_KEY /etc/default/notifiarr 2>/dev/null; then
    read -n36 -p "==> Enter Notifiarr.com notifiarr-bot API Key: " APIKEY
    echo
    echo "DN_API_KEY=${APIKEY}" | sudo tee    /etc/default/notifiarr >/dev/null
    echo "DN_APT=true"          | sudo tee -a /etc/default/notifiarr >/dev/null
    echo "DN_QUIET=true"        | sudo tee -a /etc/default/notifiarr >/dev/null
    echo "DN_DEBUG=true"        | sudo tee -a /etc/default/notifiarr >/dev/null
    echo "DN_MAX_BODY=10000"    | sudo tee -a /etc/default/notifiarr >/dev/null
    echo "DN_LOG_FILES=10"      | sudo tee -a /etc/default/notifiarr >/dev/null
    echo "DN_LOG_FILE_MB=10"    | sudo tee -a /etc/default/notifiarr >/dev/null
fi

if [ "$(hostname -s)" != "carolina" ]; then
    sudo mkdir -p /home/abc/mulery
    echo "==> Copying mulery.conf from your home folder on carolina.notifiarr.com"
    ssh carolina.notifiarr.com cat mulery.conf | \
    sed "s/carolina/$(hostname -s)/g" | \
    sudo tee /home/abc/mulery/mulery.conf > /dev/null
fi

DEBIAN_FRONTEND=noninteractive

echo "==> Adding Nonpublic Golift APT repo w/ notifiarr-forest"
curl -sL https://packagecloud.io/golift/nonpublic/gpgkey | gpg --dearmor | \
    sudo tee /usr/share/keyrings/golift-nonpublic-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/golift-nonpublic-keyring.gpg] https://packagecloud.io/golift/nonpublic/ubuntu focal main" | \
    sudo tee /etc/apt/sources.list.d/golift-nonpublic.list > /dev/null

sudo apt update
sudo apt install -y notifiarr-forest

echo "==> Installing Golift APT repo w/ notifiarr client"
curl -s https://golift.io/repo.sh | sudo bash -s - notifiarr

if [ ! -f /etc/telegraf/telegraf.d/influxdb.conf ]; then
    echo "==> Copying /etc/telegraf/telegraf.d/influxdb.conf from carolina.notifiarr.com"
    scp carolina.notifiarr.com:/etc/telegraf/telegraf.d/influxdb.conf /tmp && \
    sudo mv /tmp/influxdb.conf /etc/telegraf/telegraf.d/influxdb.conf
    sudo systemctl restart telegraf
fi