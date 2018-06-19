#!/bin/bash

if [ ! -f /home/pi/scripts/default.hvac.sitemap ]; then
  cp /etc/openhab2/sitemaps/default.sitemap /home/pi/scripts/default.hvac.sitemap;
fi
cp /home/pi/scripts/default.nohvac.sitemap /etc/openhab2/sitemaps/default.sitemap;

if [ ! -f /home/pi/scripts/default.hvac.rules ]; then
  cp /etc/openhab2/rules/default.rules /home/pi/scripts/default.hvac.rules;
fi
cp /home/pi/scripts/default.nohvac.rules /etc/openhab2/rules/default.rules;

if [ ! -f /home/pi/scripts/default.hvac.items ]; then
  cp /etc/openhab2/items/default.items /home/pi/scripts/default.hvac.items;
fi
cp /home/pi/scripts/default.nohvac.items /etc/openhab2/items/default.items;

if [ ! -f /home/pi/scripts/habpanel.hvac.config ]; then
  cp /var/lib/openhab2/config/org/openhab/habpanel.config /home/pi/scripts/habpanel.hvac.config;
fi
sudo cp /home/pi/scripts/habpanel.nohvac.config /var/lib/openhab2/config/org/openhab/habpanel.config

cp /home/pi/scripts/bme280C.py /home/pi/scripts/bme280.py;
sudo service openhab2 restart;
