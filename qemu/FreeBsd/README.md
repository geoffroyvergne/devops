# Qemu

https://wiki.gentoo.org/wiki/QEMU/Options

# Run FreeBSD

## Create disk
qemu-img create -f qcow2 ~/qemu-vms/freebsd-disk.img 50G
qemu-img info ~/qemu-vms/freebsd-disk.img

qemu-img create -f qcow2 ~/qemu-vms/freebsd.qcow2 20G

## Install
qemu-system-x86_64 \
    -drive file=/Users/gv/qemu-vms/freebsd-disk.img,index=0,media=disk,format=qcow2 \
    -device virtio-net,netdev=bridge0 -netdev user,id=vmnic \
    -cdrom ~/data/iso/FreeBSD-13.0-CURRENT-amd64-bootonly.iso \
    -boot d


    -net nic \
    -net user

    -display curses \

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -cdrom ~/Downloads/FreeBSD-12.1-RELEASE-amd64-bootonly.iso \
    -accel hvf \
    -display cocoa,show-cursor=on \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne//qemu-vms/freebsd.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -smp 2

## Run

qemu-system-x86_64 \
    -m 2048 \
    -accel hvf \
    -display cocoa,show-cursor=on \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne/qemu-vms/freebsd.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -vga virtio \
    -smp 2

-vga [std|cirrus|vmware|qxl|xenfb|tcx|cg3|virtio|none]

qemu-system-x86_64 \
    -accel hvf \
    -drive file=/Users/gv/qemu-vms/freebsd-disk.img,index=0,media=disk,format=qcow2 \
    -cpu host \
    -smp 2 \
    -m 1024M \
    -vga std \
    -global VGA.vgamem_mb=128

## Xorg

Xorg -configure
Xorg -config xorg.conf.new -retro

section device
driver "scfb"

scfb
modesetting
vesa