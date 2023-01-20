
qemu-img create -f qcow2 ~/data/qemu/openbsd.qcow2 60G

qemu-system-aarch64 \
    -M virt \
    -accel hvf \
    -m 2048 \
    -cpu cortex-a57 -M virt,highmem=off \
    -drive file=/opt/homebrew/Cellar/qemu/7.0.0_1/share/qemu/edk2-aarch64-code.fd,if=pflash,format=raw,readonly=on \
    -drive file=/Users/gv/data/iso/openbsd-71.img,format=raw,readonly=on \
    -drive file=/Users/gv/data/qemu/openbsd.qcow2,index=1,media=disk,format=qcow2 \
    -nographic

ftp.fr.openbsd.org
https://ftp.fr.openbsd.org/pub/OpenBSD/

qemu-system-aarch64 \
    -M virt \
    -accel hvf \
    -drive file=/Users/gv/data/qemu/openbsd.qcow2,index=1,media=disk,format=qcow2 \
    -m 2048 \
    -cpu cortex-a57 -M virt,highmem=off \
    -display sdl,gl=on -device ramfb -device usb-ehci,id=ehci \
    -device usb-mouse,bus=ehci.0 -device usb-kbd,bus=ehci.0

qemu-system-aarch64 \
    -M virt,highmem=off \
    -accel hvf \
    -cpu host \
    -smp 4 \
    -m 2048 \
    -display default,show-cursor=on \
    -device qemu-xhci \
    -device usb-kbd \
    -device usb-tablet \
    -device intel-hda \
    -device hda-duplex \
    -drive file=/Users/gv/data/iso/openbsd-71.img,format=raw,readonly=on \
    -drive file=/Users/gv/data/qemu/openbsd.qcow2,if=virtio,cache=writethrough