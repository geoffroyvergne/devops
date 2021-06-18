# DevOps

## terminal

ctrl a : end of line
ctrl e : begining of line

## Vim

fn up fn down : vim page up down
fn right left : vim begining end line

## Browser

cmd 1 to n : change tab
cmd option left right : move tab

## Backup dev folder

rsync -r --exclude 'target/' --exclude 'node_modules/' --exclude 'data/' --exclude 'packer_cache' --exclude 'bin' --exclude 'venv' --exclude 'pkg' $HOME/dev $HOME/data/backups/dev_backup

## Usb disk virtualbox

sudo chown gv /dev/disk2s2
sudo VBoxManage internalcommands createrawvmdk -filename ~/virtual-disks/disk2.vmdk -rawdisk /dev/disk2s2
