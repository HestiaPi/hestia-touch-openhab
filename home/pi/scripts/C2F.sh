#!/bin/bash

rm -f "/home/pi/scripts/bme280.py";
cp /home/pi/scripts/bme280F.py /home/pi/scripts/bme280.py;

sed -i 's/\/\/FAHRENHEIT/\/**FAHRENHEIT*\//g' /etc/openhab2/sitemaps/default.sitemap;
sed -i 's/\/\*\*CELSIUS\*\//\/\/CELSIUS/g' /etc/openhab2/sitemaps/default.sitemap;
sed -i 's/\/\/FAHRENHEIT/\/**FAHRENHEIT*\//g' /etc/openhab2/rules/default.rules;
sed -i 's/\/\*\*CELSIUS\*\//\/\/CELSIUS/g' /etc/openhab2/rules/default.rules;
sed -i 's/1f °C/0f °F/g' /etc/openhab2/items/default.items;
