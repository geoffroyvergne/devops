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

# MIPS

https://markuta.com/how-to-build-a-mips-qemu-image-on-debian/

https://cdimage.debian.org/debian-cd/current/mips/iso-cd/debian-10.10.0-mips-netinst.iso

## Create disk

qemu-img create -f qcow2 ~/qemu-vms/debian-mips.qcow2 2G

## Install

http://ftp.debian.org/debian/dists/stable/main/installer-mips/current/images/malta/netboot/initrd.gz
http://ftp.debian.org/debian/dists/stable/main/installer-mips/current/images/malta/netboot/vmlinux-4.19.0-17-4kc-malta

qemu-system-mips -M malta \
  -m 256 -hda /Users/gv/qemu-vms/debian-mips.qcow2 \
  -kernel /Users/gv/qemu-vms/iso/debian-mips/vmlinux-4.19.0-17-4kc-malta \
  -initrd /Users/gv/qemu-vms/iso/debian-mips/initrd.gz \
  -append "console=ttyS0 nokaslr" \
  -nographic

## run

qemu-system-mips -M malta \
  -m 256 -hda /Users/gv/Downloads/qemu-vms/debian-mips.qcow2 \
  -kernel /Users/gv/qemu-vms/iso/debian-mips/vmlinux-4.19.0-17-4kc-malta \
  -initrd /Users/gv/qemu-vms/iso/debian-mips/initrd.gz \
  -append "root=/dev/sda1 console=ttyS0 nokaslr" \
  -nographic \
  -device e1000-82545em,netdev=user.0 \
  -netdev user,id=user.0,hostfwd=tcp::5555-:22

