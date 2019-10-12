#!/bin/bash
# This will check from ipinfo.io if your public IP has changed and only then it will push it.
# Make sure this script is executble (sudo chmod +x /home/pi/scripts/publicip.sh) and add it to crontab
#sudo crontab -e
#[add this at the end, to check every hour]
#0 * * * * /home/pi/scripts/publicip.sh

ip=$(ping -c 1 ipinfo.io | awk -F'[()]' '/PING/{print $2}')
if [ "$ip" == "192.168.4.1" ]
 then
 echo "Not connected" > /tmp/publicip  # overwrite for next run
 exit 0;
fi

publicip=$(wget --timeout=10 http://ipinfo.io/ip -qO -)
touch /tmp/publicip
if [ "$publicip" != "$(cat /tmp/publicip)" ]
  then
  echo $publicip > /tmp/publicip  # overwrite for next run
  # Run dyndns updater
  # dtdns is now dead :( use no-ip.com instead
  #/usr/bin/wget -O - -q -t 1 "http://www.dtdns.com/api/autodns.cfm?id=[YOUR-DTDNS-DOMAIN]&pw=[YOUR-DTDNS-PASS]&client=HestiaPiDDNSUpdater"
  #/usr/bin/wget -O - -q -t 1 "http://[USERNAME]:[PASSWORD]@dynupdate.no-ip.com/nic/update?hostname=[YOUR-HOSTNAME]"
fi

