# Qemu

# Run windows

## Create disk

qemu-img create -f qcow2 ~/qemu-vms/windows10.qcow2 20G

## Install

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -cdrom /Users/gv/Downloads/Win10_21H1_French_x64.iso \
    -accel hvf \
    -display cocoa,show-cursor=on \
    -usb -device usb-kbd -device usb-tablet \
    -drive file=/Users/gv/qemu-vms/windows10.qcow2,if=virtio \
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

