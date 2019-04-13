#!/bin/sh

set -e
set -x

if [ "$PACKER_BUILDER_TYPE" != "virtualbox-iso" ]; then
  exit 0
fi

sudo pkg install -y virtualbox-ose-additions-nox11

#sudo pkg install -y virtualbox-ose-5.2.26_4       # General-purpose full virtualizer for x86 hardware
#sudo pkg install -y virtualbox-ose-additions-5.2.26_4 # VirtualBox additions for FreeBSD guests
#sudo pkg install -y virtualbox-ose-kmod-5.2.26     # VirtualBox kernel module for FreeBSD


sudo tee -a /etc/rc.conf <<EOF
vboxguest_enable="YES"
vboxservice_enable="YES"
EOF
