#!/bin/bash

rm -f /etc/wpa_supplicant/wpa_supplicant.conf;
cp /home/pi/scripts/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf;
sudo find /var/log -type f -delete;
sudo rm -f /home/pi/.bash_history;
sudo rm -f /var/lib/openhab2/persistence/rrd4j/*.rrd;
sudo rm -f /home/pi/scripts/raspberry-pi-turnkey/pi.id;
sudo rm -f /var/lib/openhab2/uuid;
sudo rm -f /var/lib/openhab2/openhabcloud/secret;
sudo openhab-cli reset-ownership
sudo shutdown -h now;
