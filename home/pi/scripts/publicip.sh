#!/bin/bash

publicip=$(wget --timeout=10 http://ipinfo.io/ip -qO -)
touch /tmp/publicip
 if [ "$publicip" != "$(cat /tmp/publicip)" ]
  then
  echo $publicip > /tmp/publicip  # overwrite for next run
  # Run dyndns updater
  /usr/bin/wget -O - -q -t 1 "http://www.dtdns.com/api/autodns.cfm?id=[YOUR-DTDNS-DOMAIN]&pw=[YOUR-DTDNS-PASS]&client=HestiaPiDDNSUpdater"
fi
