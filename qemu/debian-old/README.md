# Qemu

https://wiki.debian.org/QEMU

## Create disk


qemu-img create -f qcow2 ~/qemu-vms/debian-disk.img 50G

qemu-img create -f qcow2 -o cluster_size=2M ~/qemu-vms/debian-disk.img 50G

qemu-img create -f qcow2 -o preallocation=metadata,compat=1.1,lazy_refcounts=on ~/qemu-vms/debian-disk.img 50G


qemu-img resize ~/qemu-vms/debian-10-openstack-amd64.qcow2 50G


## Install
qemu-system-x86_64 \
    -drive file=/Users/gv/qemu-vms/debian-disk.img,index=0,media=disk,format=qcow2 \
    -cdrom ~/Downloads/debian-10.10.0-amd64-netinst.iso \
    -boot d \
    -m 1024

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -display cocoa,show-cursor=on \
    -usb -device usb-tablet \
    -cdrom ~/Downloads/debian-10.10.0-amd64-netinst.iso \
    -drive file=/Users/gv/qemu-vms/debian-10-openstack-amd64.qcow2 \
    -accel hvf \
    -cpu Penryn,vendor=GenuineIntel


## Run
qemu-system-x86_64 -drive file=/Users/gv/qemu-vms/debian-disk.img,index=0,media=disk,format=qcow2 \ -m 512

qemu-system-x86_64 \
    -m 2048 \
    -vga virtio \
    -display cocoa,show-cursor=on \
    -usb -device usb-tablet \    
    -drive file=/Users/gv/qemu-vms/debian-10-openstack-amd64.qcow2 \
    -accel hvf \
    -cpu Penryn,vendor=GenuineIntel