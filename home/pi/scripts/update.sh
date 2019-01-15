#!/bin/bash

# Script that updates all script files from Gihub
# Usage: sudo ./update.sh [OPTIONS]
# If no options are specified, user will be prompted
# 1: Load HVAC UI, F unit and don not reboot
# 2: Load Standard UI, C unit and don not reboot
# 3: Update only the update script and exit

if [ "$1" = "1" ]; then
  echo "HVAC selected";
  UI=1;
  Unit=1;
  DoReboot=2;
elif [ "$1" = "2" ]; then
  echo "Standard selected";
  UI=2;
  Unit=2;
  DoReboot=2;
elif [ "$1" = "3" ]; then
  echo "Updating update script...";
  wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/update.sh -O /home/pi/scripts/update.sh --backups=1;
  sudo chmod 755 update.sh;
  exit 0;
else
  echo "Choose UI:";
  select yn in "HVAC (US)" "Standard (EU)"; do
      case $yn in
          "HVAC (US)" )  echo Loading HVAC elements...; UI=1;
                break;;
          "Standard (EU)" )  echo Loading Standard elements...; UI=2;
               break;;
      esac
  done

  echo "Choose temperature Unit:";
  select yn in "Fahrenheit (F)" "Celsius (C)"; do
      case $yn in
          "Fahrenheit (F)" ) echo Using F unit...; Unit=1; break;;
          "Celsius (C)" ) echo Using C unit; Unit=2; break;;
      esac
  done

  echo "Please reboot to update LCD UI";
  select yn in "Reboot now" "Don't reboot"; do
      case $yn in
          "Reboot now" ) echo Will reboot; DoReboot=1; break;;
          "Don't reboot" ) echo Will not reboot; DoReboot=2; break;;
      esac
  done
fi
echo "Update started";


# Generic code goes here

sudo chmod 777 /etc/openhab2/rules /etc/openhab2/sitemaps /etc/openhab2/items /etc/openhab2/persistence /etc/openhab2/transform;
sudo chmod 777 /etc/openhab2/rules/default.rules /etc/openhab2/sitemaps/default.sitemap /etc/openhab2/items/default.items /etc/openhab2/things/default.things /etc/openhab2/persistence/rrd4j.persist /etc/openhab2/transform/binary.map;
sudo mkdir /etc/openhab2/html/hestiapi;
sudo chmod 777 /etc/openhab2/html /etc/openhab2/html/hestiapi;
mkdir /home/pi/scripts/update;
cd /home/pi/scripts/update;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/etc/openhab2/rules/default.rules;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/etc/openhab2/sitemaps/default.sitemap;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/etc/openhab2/items/default.items;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/etc/openhab2/things/default.things;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/etc/openhab2/persistence/rrd4j.persist;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/etc/openhab2/transform/binary.map;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/etc/openhab2/html/hestiapi/hestiapi.css;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/default.hvac.items;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/default.hvac.rules;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/default.hvac.sitemap;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/habpanel.hvac.config;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/habpanel.nohvac.config;


if [ "$UI" = "1" ]; then
  echo "Loading HVAC Ui elements...";
  sudo mv default.rules /home/pi/scripts/default.nohvac.rules;
  sudo mv default.sitemap /home/pi/scripts/default.nohvac.sitemap;
  sudo mv default.items /home/pi/scripts/default.nohvac.items;
  sudo mv default.hvac.rules /etc/openhab2/rules/default.rules;
  sudo mv default.hvac.sitemap /etc/openhab2/sitemaps/default.sitemap;
  sudo mv default.hvac.items /etc/openhab2/items/default.items;
  sudo cp habpanel.hvac.config /var/lib/openhab2/config/org/openhab/habpanel.config;
  echo "HVAC UI elements loaded!";
elif [ "$UI" = "2" ]; then
  echo "Loading Standard Ui elements...";
  sudo mv default.rules /etc/openhab2/rules/default.rules;
  sudo mv default.sitemap /etc/openhab2/sitemaps/default.sitemap;
  sudo mv default.items /etc/openhab2/items/default.items;
  sudo cp habpanel.nohvac.config /var/lib/openhab2/config/org/openhab/habpanel.config;
  echo "Standard UI elements loaded!";
else
  echo "Invalid selection"
fi

# Generic code goes here

sudo mv default.things /etc/openhab2/things/default.things;
sudo mv rrd4j.persist /etc/openhab2/persistence/rrd4j.persist;
sudo mv binary.map /etc/openhab2/transform/binary.map;
sudo mv hestiapi.css /etc/openhab2/html/hestiapi/hestiapi.css;
sudo chmod 777 /etc/openhab2/html/hestiapi/hestiapi.css;
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
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getBMEpress.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getcputemperature.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getssid.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/gettz.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getuseddiskspace.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getwifiinfo.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getwlan0ip.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/getwlan0mac.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/HVACEnable.sh;
wget https://github.com/HestiaPi/hestia-touch-openhab/raw/master/home/pi/scripts/HVACDisable.sh;
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
sudo chmod 755 AdafruitDHTHum.py AdafruitDHTTemp.py getBMEhumi.sh getBMEtemp.sh getBMEpress.sh getcputemperature.sh getssid.sh gettz.sh getuseddiskspace.sh getwifiinfo.sh getwlan0ip.sh getwlan0mac.sh HVACEnable.sh HVACDisable.sh netcheck.sh openhabloader.sh packitupandgo.sh update.sh publicip.sh;
sudo chmod 644 openhabloader.blank.html openhabloader.html wpa_supplicant.conf;
rmdir /home/pi/scripts/update;


if [ "$Unit" = "1" ]; then
  echo "Using F unit..."; sudo /home/pi/scripts/C2F.sh;
elif [ "$Unit" = "2" ]; then
  echo "Using C unit..."; sudo /home/pi/scripts/F2C.sh;
else
  echo "Invalid unit selection"
fi

if [ "$DoReboot" = "1" ]; then
  echo "Rebooting..."; sudo reboot;
elif [ "$DoReboot" = "2" ]; then
  echo "Update completed!";
  exit 0;
fi
