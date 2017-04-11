#!/bin/bash

python /home/pi/scripts/bme280.py | grep Temperature | awk '{print $3}' | cut -c1-4
