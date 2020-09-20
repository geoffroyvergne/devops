# Coreos
## Fedora CoreOS

https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/

https://getfedora.org/coreos/download?tab=metal_virtualized&stream=stable

unxz fedora-coreos-qemu.qcow2.xz

qemu-kvm -m 2048 -cpu host -nographic -snapshot \
	-drive if=virtio,file=/Users/gv/data/iso/fedora-coreos-31.20200517.3.0-qemu.x86_64.qcow2 \
	-fw_cfg name=opt/com.coreos/config,file=path/to/example.ign