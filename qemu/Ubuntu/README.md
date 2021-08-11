# Qemu

https://wiki.gentoo.org/wiki/QEMU/Options

# Run NetBSD

## Create disk
qemu-img create -f qcow2 ~/qemu-vms/ubuntu-disk.img 50G

qemu-img info ~/qemu-vms/ubuntu-disk.img

qemu-img create -f qcow2 ~/qemu-vms/ubuntu.qcow2 20G

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

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -cdrom /Users/geoffroy.vergne/Downloads/ubuntu-mate-21.04-desktop-amd64.iso \
    -accel hvf \
    -display cocoa,show-cursor=on \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne/qemu-vms/ubuntu.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -smp 2

## Run

-vga [std|cirrus|vmware|qxl|xenfb|tcx|cg3|virtio|none]

qemu-system-x86_64 \
    -accel hvf \
    -drive file=/Users/gv/qemu-vms/ubuntu-disk.img,index=0,media=disk,format=qcow2 \
    -m 1024 \
    -vga vmware \
    -global VGA.vgamem_mb=128

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -accel hvf \
    -display cocoa,show-cursor=on \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne/qemu-vms/ubuntu.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -smp 2