# Clamav antivirus

https://medium.com/@wingsuitist/set-up-clamav-for-osx-1-the-open-source-virus-scanner-82a927b60fa3

https://blog.anotherhomepage.org/post/2017/02/13/clamav-installation-et-scan-antivirus-sur-macos

## install
brew install clamav

cd /usr/local/etc/clamav
cp freshclam.conf.sample freshclam.conf

sed -ie 's/^Example/#Example/g' freshclam.conf

/usr/local/etc/clamav/clamd.conf

## update database
freshclam -v

sudo clamscan -r / --exclude=/Volumes --exclude=/Users -i -l ~/clamscan_report_root.txt

sudo clamscan -r ~/ --exclude=~/data --exclude=onedrive -exclude=Dropbox --exclude="Google\ Drive\ Perso" --exclude="VirtualBox\ VM" --exclude=VirtualMachines -i -l ~/clamscan_report_home.txt

sudo clamscan -r ~/data -i -l ~/clamscan_report_data.txt

