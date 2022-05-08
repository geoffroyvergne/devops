#!/bin/bash

set -e
set -x

sudo ln -s /usr/bin/python3 /usr/bin/python

sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=1/' /etc/default/grub
sudo update-grub
