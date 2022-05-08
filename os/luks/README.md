# LUKS

## lukskeyfile :

sudo dd if=/dev/urandom of=/root/lukskeyfile bs=1024 count=4
sudo chmod 0400 /root/lukskeyfile
sudo cryptsetup luksAddKey /dev/sdb1 /root/lukskeyfile
sudo cryptsetup luksOpen /dev/sdb1 secured --key-file /root/lukskeyfile

## volume chiffré :

sudo cryptsetup luksOpen /dev/sdb1 secured
sudo mount /dev/mapper/secured /secured

ls -la /secured

sudo umount /secured
sudo cryptsetup luksClose secured


https://www.howtoforge.com/automatically-unlock-luks-encrypted-drives-with-a-lukskeyfile

UUID:          	4d908f93-2666-4af2-ad12-912871d05ba0

/etc/crypttab
secured 4d908f93-2666-4af2-ad12-912871d05ba0 /root/lukskeyfile luks

sudo cryptdisks_start secured

/etc/fstab
/dev/mapper/secured /secured ext4    defaults   0       2

sudo cryptdisks_start secured
sudo mount /dev/mapper/secured /secured
