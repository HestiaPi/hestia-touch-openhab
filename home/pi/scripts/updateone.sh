#!/bin/bash

ip=$(ping -c 1 github.com | awk -F'[()]' '/PING/{print $2}')
if [ "$ip" == "192.168.4.1" ]
 then
 echo "No Internet"
 exit 0;
fi

### PREPARE UPDATE FOLDER
sudo mkdir /home/pi/scripts/gitupdate;
cd /home/pi/scripts/gitupdate;
sudo git clone --single-branch --branch ONE https://github.com/HestiaPi/hestia-touch-openhab.git;
cd /home/pi/scripts/gitupdate/hestia-touch-openhab
sudo rm -rf .git LICENSE README.md;

### PREPARE FILES AND OVERWRITE THEM
cd /etc/openhab2;
sudo chmod 777 rules sitemaps items transform;
sudo chmod 777 sitemaps/default.sitemap items/default.items things/default.things transform/binary.map;
sudo rm rules/default.rules;
sudo rsync -rtcsOa /home/pi/scripts/gitupdate/hestia-touch-openhab/ /;
sudo chown pi:pi /home/pi/ ;

### SET PERMISSIONS
cd /home/pi/scripts/;
sudo chmod a+w /home/pi/scripts/;
sudo touch gitinstalledversion humiditymode systemtype tempunit /tmp/publicip;
sudo chmod 777 gitinstalledversion humiditymode systemtype tempunit /tmp/publicip;
sudo chmod 777 F2C.sh C2F.sh bme280.py bme280C.py bme280F.py;
sudo chmod 755 AdafruitDHTHum.py AdafruitDHTTemp.py *.sh;
sudo chmod 644 openhabloader.blank.html openhabloader.html wpa_supplicant.conf;
sudo openhab-cli reset-ownership

### STORE VERSION NUMBER LOCALLY
sudo curl --silent "https://api.github.com/repos/hestiapi/hestia-touch-openhab/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' > /home/pi/scripts/gitinstalledversion;
sudo rm -rf /home/pi/scripts/gitupdate;
sudo reboot;

exit 0;
