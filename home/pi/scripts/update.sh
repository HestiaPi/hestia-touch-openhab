#!/bin/bash

# Script that updates all script files from Gihub
# Usage: sudo ./update.sh


sudo chmod 777 /etc/openhab2/rules /etc/openhab2/sitemaps /etc/openhab2/items;
sudo chmod 777 /etc/openhab2/rules/default.rules /etc/openhab2/sitemaps/default.sitemap /etc/openhab2/items/default.items;
mkdir /home/pi/scripts/update;
cd /home/pi/scripts/update;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/F2C.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/C2F.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/bme280.py;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/bme280C.py;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/bme280F.py;
sudo mv /home/pi/scripts/update/* /home/pi/scripts/;
cd /home/pi/scripts/;
sudo chmod 777 F2C.sh C2F.sh bme280.py bme280C.py bme280F.py;
cd /home/pi/scripts/update;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/AdafruitDHTHum.py;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/AdafruitDHTTemp.py;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getBMEhumi.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getBMEtemp.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getcputemperature.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getssid.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/gettz.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getuseddiskspace.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getwifiinfo.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getwlan0ip.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getwlan0mac.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/netcheck.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/openhabloader.blank.html;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/openhabloader.html;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/openhabloader.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/packitupandgo.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/update.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/publicip.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/wpa_supplicant.conf;
sudo mv /home/pi/scripts/update/* /home/pi/scripts/;
cd /home/pi/scripts/;
sudo chmod 755 AdafruitDHTHum.py AdafruitDHTTemp.py getBMEhumi.sh getBMEtemp.sh getcputemperature.sh getssid.sh gettz.sh getuseddiskspace.sh getwifiinfo.sh getwlan0ip.sh getwlan0mac.sh netcheck.sh openhabloader.sh packitupandgo.sh update.sh publicip.sh;
sudo chmod 644 openhabloader.blank.html openhabloader.html wpa_supplicant.conf;
rmdir /home/pi/scripts/update;
