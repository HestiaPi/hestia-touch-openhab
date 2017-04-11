#!/bin/bash

ip addr show wlan0 | grep link\/ | awk '{print $2}' | cut -d/ -f1;

