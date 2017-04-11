#!/bin/bash

python /home/pi/scripts/bme280.py | grep Humidity | awk '{print $3}' | cut -c -4
