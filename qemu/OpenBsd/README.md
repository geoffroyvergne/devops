# Qemu

https://wiki.gentoo.org/wiki/QEMU/Options

# Run OpenBSD

## Create disk
qemu-img create -f qcow2 ~/qemu-vms/openbsd-disk.img 50G

qemu-img info ~/qemu-vms/openbsd-disk.img

qemu-img create -f qcow2 ~/qemu-vms/openbsd.qcow2 20G

## Install
qemu-system-x86_64 \
    -accel hvf \
    -m 1024M \
    -drive file=/Users/gv/qemu-vms/openbsd-disk.img,index=0,media=disk,format=qcow2 \
    -cdrom ~/data/iso/OpenBSD-install66.iso \
    -cpu host \
    -smp 2 \
    -boot d

    -display curses \
    -net nic \
    -net user

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -cdrom ~/Downloads/install69.iso \
    -accel hvf \
    -display cocoa,show-cursor=off \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne/qemu-vms/openbsd.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -smp 2

## Run

-vga [std|cirrus|vmware|qxl|xenfb|tcx|cg3|virtio|none]

qemu-system-x86_64 \
    -accel hvf \
    -drive file=/Users/gv/qemu-vms/openbsd-disk.img,index=0,media=disk,format=qcow2 \
    -cpu host \
    -smp 2 \
    -m 1024M \
    -vga std \
    -global VGA.vgamem_mb=128 

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -accel hvf \
    -display cocoa,show-cursor=off \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne/qemu-vms/openbsd.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -smp 2
