#!/bin/bash

# This is the entry point for setting up a worker. Download and run this script on a fresh Ubuntu 22.04 server.
# Make sure the new server has access to the NFS /share (see below). It's safe to run this more than once; in case you forgot.

read -p "Notifiarr.com API Key:" APIKEY
echo "DN_API_KEY=$APIKEY" | sudo tee /etc/default/notifiarr > /dev/null

curl -s https://golift.io/repo.sh | sudo bash -s - notifiarr

echo "Adding Nonpublic Golift APT repo"
curl -sL https://packagecloud.io/golift/nonpublic/gpgkey | gpg --dearmor > /tmp/golift-nonpublic-keyring.gpg && \
    sudo mv -f /tmp/golift-nonpublic-keyring.gpg /usr/share/keyrings/golift-nonpublic-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/golift-nonpublic-keyring.gpg] https://packagecloud.io/golift/nonpublic/ubuntu focal main" | \
    sudo tee /etc/apt/sources.list.d/golift-nonpublic.list

sudo apt update
sudo apt install -y notifiarr-forest

echo "Copying mulery.conf and running docker-compose up -d in /etc/mulery"

scp safrica.notifiarr.com:/etc/mulery/mulery.conf /tmp && \
    sed -i'' "s/safrica/$(hostname -s)/g" /tmp/mulery.conf && \
    sudo cp /tmp/mulery.conf /etc/mulery/mulery.conf && \
    cd /etc/mulery && \
    sudo docker-compose up -d 
