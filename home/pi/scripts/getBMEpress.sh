#!/bin/bash

python /home/pi/scripts/bme280.py | grep Pressure | awk '{print $3}' | cut -c -6
