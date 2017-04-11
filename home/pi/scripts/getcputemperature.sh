#!/bin/bash

cat /sys/class/thermal/thermal_zone0/temp | cut -c -3 | cut -c -2

