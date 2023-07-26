#!/bin/bash

used=$(df | grep root  | awk '{print $5}' | sed 's/%.*//g')
echo $used "%"
