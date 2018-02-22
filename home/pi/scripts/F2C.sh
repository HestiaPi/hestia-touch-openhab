#!/bin/bash

rm -f "/home/pi/scripts/bme280.py";
cp /home/pi/scripts/bme280C.py /home/pi/scripts/bme280.py;

#rm -f "/etc/openhab2/sitemaps/default.sitemap";
#cp /home/pi/scripts/defaultC.sitemap /etc/openhab2/sitemaps/default.sitemap;
sed -i 's/\/\/CELSIUS/\/**CELSIUS*\//g' /etc/openhab2/sitemaps/default.sitemap;
sed -i 's/\/\*\*FAHRENHEIT\*\//\/\/FAHRENHEIT/g' /etc/openhab2/sitemaps/default.sitemap;
sed -i 's/\/\/CELSIUS/\/**CELSIUS*\//g' /etc/openhab2/rules/default.rules;
sed -i 's/\/\*\*FAHRENHEIT\*\//\/\/FAHRENHEIT/g' /etc/openhab2/rules/default.rules;
sed -i 's/0f °F/1f °C/g'  /etc/openhab2/items/default.items;
