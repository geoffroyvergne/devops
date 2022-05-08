#!/bin/sh

echo "autoboot_delay=1" | sudo tee -a /boot/loader.conf

# sudo pkg install -y vim
sudo pkg install -y python
sudo ln -s /usr/local/bin/python /usr/bin/python
