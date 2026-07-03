#!/bin/bash

used=$(df -P / | awk 'NR==2 {print $5}' | tr -d '%')
echo $used "%"
