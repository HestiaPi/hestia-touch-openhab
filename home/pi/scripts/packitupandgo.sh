#!/bin/bash

if [ $(id -u) -ne 0 ]; then
    printf "\n"
    printf "script must be run as root\n"
    exit 1
fi
sudo systemctl stop openhab2
yes | sudo openhab-cli clean-cache
rm -f /etc/wpa_supplicant/wpa_supplicant.conf;
cp /home/pi/scripts/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf;
sudo find /var/log -type f -delete;
sudo rm -f /home/pi/.bash_history;
sudo rm -f /var/lib/openhab2/persistence/rrd4j/*.rrd;
sudo rm -f /home/pi/scripts/raspberry-pi-turnkey/pi.id;
sudo rm -f /home/pi/scripts/raspberry-pi-turnkey/status.json;
sudo rm -f /var/lib/openhab2/uuid;
sudo rm -f /var/lib/openhab2/openhabcloud/secret;
sudo openhab-cli reset-ownership
sudo shutdown -h now;
