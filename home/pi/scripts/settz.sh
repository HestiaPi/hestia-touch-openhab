#!/bin/bash

#touch /home/pi/scripts/tztest
#echo $1 > /home/pi/scripts/tztest
sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/$1 /etc/localtime
sudo rm /etc/timezone
exit;
