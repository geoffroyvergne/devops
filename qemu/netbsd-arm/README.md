
qemu-img create -f qcow2 ~/data/qemu/netbsd.qcow2 60G

qemu-system-aarch64 \
    -M virt \
    -accel hvf \
    -m 2048 \
    -cpu cortex-a57 -M virt,highmem=off \
    -drive file=/opt/homebrew/Cellar/qemu/7.1.0/share/qemu/edk2-aarch64-code.fd,if=pflash,format=raw,readonly=on \
    -drive file=/Users/gv/data/bsd/NetBSD-9.3-evbarm-aarch64.iso,format=raw,readonly=on \
    -drive file=/Users/gv/data/qemu/netbsd.qcow2,index=1,media=disk,format=qcow2 \
    -nographic

qemu-system-aarch64 \
    -M virt \
    -accel hvf \
    -m 2048 \
    -cpu cortex-a57 -M virt,highmem=off \
    -drive file=/opt/homebrew/Cellar/qemu/7.1.0/share/qemu/edk2-aarch64-code.fd,if=pflash,format=raw,readonly=on \
    -drive file=/Users/gv/data/bsd/netbsd-93-aarch64.img,format=raw,readonly=on \
    -drive file=/Users/gv/data/qemu/netbsd.qcow2,index=1,media=disk,format=qcow2 \
    -nographic

