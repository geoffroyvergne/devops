# Qemu

https://opensource.com/article/20/9/try-linux-mac

# Run debian

https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.10.0-amd64-netinst.iso

## Create disk

https://cdimage.debian.org/cdimage/openstack/current-10/debian-10-openstack-amd64.qcow2

qemu-img create -f qcow2 ~/qemu-vms/debian.qcow2 20G

## Install

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -cdrom /Users/geoffroy.vergne/Downloads/debian-10.10.0-amd64-netinst.iso \
    -accel hvf \
    -display cocoa,show-cursor=on \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne/qemu-vms/debian.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -smp 2


## Run

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -accel hvf \
    -display cocoa,show-cursor=on \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne/qemu-vms/debian.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -smp 2

