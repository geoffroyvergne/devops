# Qemu

https://wiki.gentoo.org/wiki/QEMU/Options

# Run NetBSD

## Create disk
qemu-img create -f qcow2 ~/qemu-vms/netbsd-disk.img 50G

qemu-img info ~/qemu-vms/netbsd-disk.img

qemu-img create -f qcow2 ~/qemu-vms/netbsd.qcow2 20G

## Install
qemu-system-x86_64 \
    -accel hvf \
    -m 1024M \
    -drive file=/Users/gv/qemu-vms/netbsd-disk.img,index=0,media=disk,format=qcow2 \
    -cdrom ~/data/iso/NetBSD-9.0-amd64.iso \
    -boot d

    -display curses \
    -net nic \
    -net user

qemu-system-x86_64 \
    -m 2048 \
    -vga std \
    -cdrom ~/Downloads/NetBSD-9.2-amd64.iso \
    -accel hvf \
    -display cocoa,show-cursor=on \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne/qemu-vms/netbsd.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -smp 2

## Run

-vga [std|cirrus|vmware|qxl|xenfb|tcx|cg3|virtio|none]

qemu-system-x86_64 \
    -accel hvf \
    -drive file=/Users/gv/qemu-vms/netbsd-disk.img,index=0,media=disk,format=qcow2 \
    -cpu host \
    -smp 2 \
    -m 1024M \
    -vnc unix:/Users/gv/qemu-vms/.qemu-myvm-vnc \
    -daemonize 

    -vga std \
    -vnc 0.0.0.0:0

    -global VGA.vgamem_mb=128

qemu-system-x86_64 \
    -m 2048 \
    -vga std \
    -accel hvf \
    -display cocoa,show-cursor=off \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne/qemu-vms/netbsd.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -smp 2