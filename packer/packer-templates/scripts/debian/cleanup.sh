#!/bin/bash

set -e
set -x

sudo apt-get clean
sudo rm /etc/discover-pkginstall.conf

sudo ln -s /usr/bin/python3 /usr/bin/python