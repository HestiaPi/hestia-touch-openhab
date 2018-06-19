#!/bin/bash

if [ ! -f /home/pi/scripts/default.nohvac.sitemap ]; then
  cp /etc/openhab2/sitemaps/default.sitemap /home/pi/scripts/default.nohvac.sitemap;
fi
cp /home/pi/scripts/default.hvac.sitemap /etc/openhab2/sitemaps/default.sitemap;

if [ ! -f /home/pi/scripts/default.nohvac.rules ]; then
  cp /etc/openhab2/rules/default.rules /home/pi/scripts/default.nohvac.rules;
fi
cp /home/pi/scripts/default.hvac.rules /etc/openhab2/rules/default.rules;

if [ ! -f /home/pi/scripts/default.nohvac.items ]; then
  cp /etc/openhab2/items/default.items /home/pi/scripts/default.nohvac.items;
fi
cp /home/pi/scripts/default.hvac.items /etc/openhab2/items/default.items;

if [ ! -f /home/pi/scripts/habpanel.nohvac.config ]; then
  cp /var/lib/openhab2/config/org/openhab/habpanel.config /home/pi/scripts/habpanel.nohvac.config;
fi
sudo cp /home/pi/scripts/habpanel.hvac.config /var/lib/openhab2/config/org/openhab/habpanel.config

cp /home/pi/scripts/bme280F.py /home/pi/scripts/bme280.py;
sudo service openhab2 restart;
