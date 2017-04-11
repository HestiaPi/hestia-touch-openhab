#!/bin/bash

ip addr show wlan0 | grep inet | head -1 | awk '{print $2}' | cut -d/ -f1;

