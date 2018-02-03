#!/bin/bash

rm -f "/home/pi/scripts/bme280.py";
cp /home/pi/scripts/bme280F.py /home/pi/scripts/bme280.py;
rm -f "/etc/openhab2/sitemaps/default.sitemap";
cp /home/pi/scripts/defaultF.sitemap /etc/openhab2/sitemaps/default.sitemap;
rm -f "/etc/openhab2/rules/default.rules";
cp /home/pi/scripts/defaultF.rules /etc/openhab2/rules/default.rules;
rm -f "/etc/openhab2/items/default.items";
cp /home/pi/scripts/defaultF.items /etc/openhab2/items/default.items;
