#!/bin/bash
# Thanks user tcrrct (https://community.hestiapi.com/u/tcrrct)

python /home/pi/scripts/bme280.py | grep Pressure | awk '{print $3}' | cut -c -6
