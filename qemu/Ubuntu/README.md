# Qemu

https://wiki.gentoo.org/wiki/QEMU/Options

# Run NetBSD

## Create disk
qemu-img create -f qcow2 ~/qemu-vms/ubuntu-disk.img 50G

qemu-img info ~/qemu-vms/ubuntu-disk.img

## Install
qemu-system-x86_64 \
    -accel hvf \
    -m 1024M \
    -drive file=/Users/gv/qemu-vms/ubuntu-disk.img,index=0,media=disk,format=qcow2 \
    -cdrom ~/data/iso/ubuntu-mate-20.04.1-desktop-amd64.iso \
    -vga vmware \
    -boot d

    -display curses \
    -net nic \
    -net user

## Run

-vga [std|cirrus|vmware|qxl|xenfb|tcx|cg3|virtio|none]

qemu-system-x86_64 \
    -accel hvf \
    -drive file=/Users/gv/qemu-vms/ubuntu-disk.img,index=0,media=disk,format=qcow2 \
    -m 1024 \
    -vga vmware \
    -global VGA.vgamem_mb=128
