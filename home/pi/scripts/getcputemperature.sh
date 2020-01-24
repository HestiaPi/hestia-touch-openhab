#!/bin/bash

temp_c=$(cat /sys/class/thermal/thermal_zone0/temp | cut -c -3 | cut -c -2)
temp_f=$(echo "(((9 * $temp_c)/5) + 32)/1" |bc)

if grep -Fxq "C" /home/pi/scripts/tempunit
then
  echo $temp_c "°C"
else
  echo $temp_f "°F"
fi
