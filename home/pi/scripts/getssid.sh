#!/bin/bash

/sbin/iwconfig wlan0 | grep -oP 'ESSID:"\K[^"]*'
