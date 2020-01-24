#!/bin/bash

used=$(df | grep root  | awk '{print $5}' | cut -c -2)
echo $used "%"
