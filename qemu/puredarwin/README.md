# Qemu

# Run Pure Darwin

https://sites.google.com/a/puredarwin.org/puredarwin/developers/qemu
https://code.google.com/archive/p/puredarwin/downloads

qemu-img convert -O qcow2 /Users/geoffroy.vergne/Downloads/puredarwinxmas.vmdk ~/qemu-vms/puredarwin.qcow2

qemu-img create -f qcow2 ~/qemu-vms/puredarwin.qcow2 20G

## Run

-vga [std|cirrus|vmware|qxl|xenfb|tcx|cg3|virtio|none]

qemu-system-x86_64 \
    -m 2048 \
    -drive file=/Users/geoffroy.vergne/qemu-vms/puredarwin.qcow2
