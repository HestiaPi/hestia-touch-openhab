#!/bin/bash

if [ $(id -u) -ne 0 ]; then
    printf "\n"
    printf "script must be run as root\n"
    exit 1
fi
sudo systemctl stop openhab2

# Delete openHAB cache
yes | sudo openhab-cli clean-cache

# Delete WiFi password
rm -f /etc/wpa_supplicant/wpa_supplicant.conf;
cp /home/pi/scripts/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf;

# Delete log files and history
sudo find /var/log -type f -delete;
sudo rm -f /home/pi/.bash_history;
sudo rm -f /var/lib/openhab2/persistence/rrd4j/*.rrd;

# Reset turnkey for WiFi provisioning
sudo rm -f /home/pi/scripts/raspberry-pi-turnkey/pi.id;
sudo rm -f /home/pi/scripts/raspberry-pi-turnkey/status.json;

# Delete backup files
sudo rm -f /home/pi/scripts/backup.zip;

# Clear openHAB cloud credentials if any
sudo rm -f /var/lib/openhab2/uuid;
sudo rm -f /var/lib/openhab2/openhabcloud/secret;

yes | sudo openhab-cli reset-ownership
sudo shutdown -h now;
