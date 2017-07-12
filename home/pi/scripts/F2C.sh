#!/bin/bash

rm -f "/home/pi/scripts/bme280.py";
cp /home/pi/scripts/bme280C.py /home/pi/scripts/bme280.py;
rm -f "/etc/openhab2/sitemaps/default.sitemap";
cp /home/pi/scripts/defaultC.sitemap /etc/openhab2/sitemaps/default.sitemap;
rm -f "/etc/openhab2/rules/default.rules";
cp /home/pi/scripts/defaultC.rules /etc/openhab2/rules/default.rules;
