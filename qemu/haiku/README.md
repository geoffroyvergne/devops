# Qemu

# Run Haiku

## Create disk

qemu-img create -f qcow2 ~/qemu-vms/haiku.qcow2 20G

## Install

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -cdrom ~/Downloads/haiku-r1beta3-x86_64-anyboot.iso \
    -accel hvf \
    -display cocoa,show-cursor=off \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne/qemu-vms/haiku.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -smp 2

## Run

-vga [std|cirrus|vmware|qxl|xenfb|tcx|cg3|virtio|none]

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -accel hvf \
    -display cocoa,show-cursor=off \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/geoffroy.vergne/qemu-vms/haiku.qcow2,if=virtio \
    -cpu Penryn,vendor=GenuineIntel \
    -smp 2

