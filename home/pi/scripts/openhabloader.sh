#!/bin/sh
### BEGIN INIT INFO
 # Provides:
 # Required-Start:
 # Required-Stop:
 # Default-Start:     2 3 4 5
 # Default-Stop:      0 1 6
 # Short-Description: Start Chromium in Kiosk mode with HAB Panel UI
 ### END INIT INFO

cd /home/pi/scripts/

wlan=$(/sbin/ifconfig wlan0 | grep inet\ addr | wc -l)
wlanip="Not available"
wlanmac="Not available"

if [ $wlan -eq 0 ]; then
/sbin/ifdown wlan0 && /sbin/ifup wlan0
else
  wlanip=$(./getwlan0ip.sh)
  wlanmac=$(./getwlan0mac.sh)
fi

if [ -f ./openhabloader.html ]; then
  rm ./openhabloader.html
fi
cp ./openhabloader.blank.html ./openhabloader.html
sed -i -e "s/wlanip/$wlanip/g" ./openhabloader.html
sed -i -e "s/wlanmac/$wlanmac/g" ./openhabloader.html

sudo -u pi /usr/bin/chromium-browser --disable-restore-session-state --disable-web-security --user-data-dir --noerordialogs --disable-session-crashed-bubble --disable-infobars --kiosk /home/pi/scripts/openhabloader.html &
xinput --set-prop 'ADS7846 Touchscreen' 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1

exit 0
