# gnupg

## download test file

wget http://ping.online.net/10Mo.dat

## crypt file

gpg -c --no-symkey-cache 10Mo.dat

gpg -c --no-symkey-cache --cipher-algo twofish --s2k-digest-algo SHA512 10Mo.dat

## crypt directory 

tar czvf test.tar.gz test
gpg -c --no-symkey-cache test.tar.gz

## package details

gpg --list-packets 10Mo.dat.gpg

## decrypt file

gpg --no-symkey-cache 10Mo.dat.gpg

## decrypt directory

gpg --no-symkey-cache test.tar.gz.gpg
tar xzf test.tar.gz
