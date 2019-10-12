#!/bin/bash

# Returns Wifi signal strength in percentage

RSSI=$(/sbin/iwconfig wlan0 | grep 'Signal level' | awk '{print $4}' | cut -d= -f2 | cut -d/ -f1);
#RSSI=-99
#echo $RSSI

if [ -z "$RSSI" ]
then
  echo "-"
elif [[ $RSSI -le -100 ]]
then
  echo "0"
elif [[ $RSSI -ge -50 ]]
then
  echo "100"
else
  echo $[2 * (RSSI + 100)] | bc
fi

