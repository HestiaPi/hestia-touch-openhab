#!/bin/bash

ip=$(ping -c 1 ipinfo.io | awk -F'[()]' '/PING/{print $2}')
if [ "$ip" == "192.168.4.1" ]
 then
 echo "No Internet"
 exit 0;
fi

curl --silent "https://api.github.com/repos/hestiapi/hestia-touch-openhab/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
exit 0;
