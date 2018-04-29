#!/bin/sh
# From https://www.raspberrypi.org/forums/viewtopic.php?t=20149
# cron script for checking WLAN connectivity
#
# to enable, make sure the script is executable
#  sudo chmod a+x /home/pi/scripts/netcheck.sh
# and then type
# sudo crontab -e
# and add this at the end to check every 10 minutes
# */10 * * * * /home/pi/scripts/netcheck.sh

IP_FOR_TEST=$(/sbin/ip route | awk '/wlan0/ ' | awk '/default/ { print $3 }' | head -1)
echo $IP_FOR_TEST
PING_COUNT=10

PING="/bin/ping"
IFUP="/sbin/ifup"
IFDOWN="/sbin/ifdown --force"

INTERFACE="wlan0"

FFLAG="/home/pi/scripts/netcheck.fflg"

$PING -c $PING_COUNT $IP_FOR_TEST > /dev/null 2> /dev/null
if [ $? -ge 1 ]
then
    echo "$INTERFACE seems to be down, trying to bring it up..."
        if [ -e $FFLAG ]
        then
                echo "$INTERFACE is still down, REBOOT to recover ..."
                rm -f $FFLAG 2>/dev/null
                sudo reboot
        else
                touch $FFLAG
                echo $(sudo $IFDOWN $INTERFACE)
                sleep 10
                echo $(sudo $IFUP $INTERFACE)
                sleep 10
                sudo dhclient $INTERFACE
        fi
else
    echo "$INTERFACE is  up"
    rm -f $FFLAG 2>/dev/null
fi
