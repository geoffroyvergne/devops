#!/bin/sh

set -e
set -x

sudo pkg install -y python
sudo ln -s /usr/local/bin/python /usr/bin/python

sudo pkg clean -a -y

