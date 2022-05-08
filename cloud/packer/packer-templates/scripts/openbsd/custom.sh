#!/bin/ksh

set -e
set -x

sudo pkg_add python-3.6.6p1
sudo ln -s /usr/local/bin/python3 /usr/bin/python

echo "set timeout 1" | sudo tee -a /etc/boot.conf