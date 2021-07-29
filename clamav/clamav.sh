#!/bin/bash

freshclam -v

rm ~/clamscan_report_**.txt

clamscan -r / --exclude-dir="/Volumes" --exclude-dir="/Users" -i -l ~/clamscan_report_root.txt
clamscan -r ~/ --exclude-dir="~/data" --exclude-dir="~/onedrive" --exclude-dir="~/Dropbox" --exclude-dir="~/Google\ Drive\ Perso" --exclude-dir="~/VirtualBox\ VM" --exclude-dir="~/VirtualMachines" -i -l ~/clamscan_report_home.txt
clamscan -r ~/data -i -l ~/clamscan_report_data.txt
