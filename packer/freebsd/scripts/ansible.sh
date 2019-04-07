#!/bin/sh -e

# Install python and root certificates
pkg install -y python ca_root_nss

# retrieve python bin
ln -s /usr/local/bin/python /usr/bin/python