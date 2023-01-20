# WIFI connection check

nmcli networking connectivity

sudo service NetworkManager status
sudo systemctl status NetworkManager

nmcli networking off 
nmcli networking on


nmcli general status

## Check wifi status
nmcli radio wifi

## Enable WIFI
nmcli radio wifi on

if [ foo ]; then a && b; elif [ bar ]; c && d; else e && f; fi




if nmcli radio wifi | grep -q 'enabled'; then echo "wifi enabled"; else echo "wifi disabled"; fi

if nmcli radio wifi | grep -q 'disabled'; then echo "wifi disabled"; else echo "wifi enabled"; fi

if nmcli radio wifi | grep -q 'disabled'; then nmcli radio wifi on; fi


if ping -c 1 192.168.1.1 &> /dev/null; then echo 1; else echo 0; fi

ping -c 1 192.168.1.1 &> /dev/null || service NetworkManager restart
