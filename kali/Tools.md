# Kali Linux tools

## Nmap

### Get all hosts in 192.168.1.0/24
192.168.1.0/24
```nmap -sV 192.168.1.0-254```

```nmap -sC -sV <ip>```

## Steghide  
is  a steganography program that is able to hide data in various kinds of image

### stegbrute steganography brute force tool
```wget https://github.com/R4yGM/stegbrute/releases/download/0.1.1/stegbrute && chmod +x stegbrute```
```sudo mv stegbrute /usr/local/bin/```

Use with wordlist
/usr/share/wordlists/rockyou.txt.gz

## Nikto HTTP vulnerability scanner
```nikto --url <ip>```
```nikto --url <ip> -C all```

## Dirb Web content scanner
```dirb <ip>```
```dirb <ip> <wordlist>```

## Find binaries with SUID permission
```find / -perm -u=s -type f 2>/dev/null```

## dnsmap Find subdomain
```dnsmap <host>```

```dnsmap <host> -w <wordlist>```
```dnsmap <host> -w /usr/share/dnsmap/wordlist_TLAs.txt```
