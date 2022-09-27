#!/bin/bash
apt-get update
apt-get install curl wget make build-essential -y
apt-get update && apt-get install --no-install-recommends -y
apt-get install gcc git curl nano apt-transport-https -y
apt-get install libxtst-dev libxext-dev libxrender-dev libfreetype6-dev -y
apt-get install libfontconfig1 libgtk2.0-0 libxslt1.1 libxxf86vm1 libpq-dev libglu1-mesa clang cmake pkg-config libgtk-3-dev -y
apt-get install sudo zip unzip file -y
apt-get install wait-for-it jq libgdal-dev libmagic-dev libgeos-dev libffi-dev libxml2-dev libxslt1-dev -y
apt-get clean && rm -rf /tmp/* /var/tmp/*