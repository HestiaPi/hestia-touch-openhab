#!/bin/bash

rm -f "/etc/wpa_supplicant/wpa_supplicant.conf";
cp /home/pi/scripts/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf;
rm -rf "/var/log/*.*"
history -w
history -c
history -w
history -c
shutdown -h now
