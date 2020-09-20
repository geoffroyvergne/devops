#!/usr/bin/env bash

PATH="build/Release:build:$PATH"

xhyve \
    -A \
    -m 1G \
    -s 0:0,hostbridge \
    -s 31,lpc \
    -l com1,stdio \
    -f kexec,data/vmlinuz,data/initrd.gz,"earlyprintk=serial console=ttyS0"
