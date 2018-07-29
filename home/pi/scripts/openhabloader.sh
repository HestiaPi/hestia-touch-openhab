#!/bin/bash
### BEGIN INIT INFO
 # Provides:
 # Required-Start:
 # Required-Stop:
 # Default-Start:     2 3 4 5
 # Default-Stop:      0 1 6
 # Short-Description: Start Chromium in Kiosk mode with HAB Panel UI
 ### END INIT INFO

# Copied from https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=174434&start=25#p1307919
# Expand the filesystem if < 3.5 GB
PARTSIZE=$( df | sed -n '/root/{s/  */ /gp}' | cut -d ' ' -f2 )
THRESHOLD=3679731

if (("$PARTSIZE" < "$THRESHOLD")) ; then
    sudo raspi-config --expand-rootfs && reboot
fi


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

pgrep chromium | xargs kill -9 #Kill all sessions in case something was hung - this will produce a restore prompt unfortunately
sudo sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
sudo sed -i 's/"exit_type":"Crashed"/"exit_type":"None"/' /home/pi/.config/chromium/Default/Preferences
sudo -u pi /usr/bin/chromium-browser --disable-restore-session-state --disable-web-security --user-data-dir --noerordialogs --disable-session-crashed-bubble --disable-infobars --kiosk /home/pi/scripts/openhabloader.html &

while :
do
if (($(echo "$(top -b -n1 | grep "load average:" | awk '{print $(NF-2)}' | cut -d, -f1) > 1.5" | bc -l))); then
  #echo 'Too busy'
  sleep 15; #Check again later
else
  #echo "Not too busy. Load!"
  pgrep chromium | xargs kill -9 #Kill all sessions in case something was hung - this will produce a restore prompt unfortunately
  sudo sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/pi/.config/chromium/Default/Preferences
  sudo sed -i 's/"exit_type":"Crashed"/"exit_type":"None"/' /home/pi/.config/chromium/Default/Preferences
  sudo -u pi /usr/bin/chromium-browser --disable-restore-session-state --disable-web-security --user-data-dir --noerordialogs --disable-session-crashed-bubble --disable-infobars --kiosk /home/pi/scripts/openhabloader.html &
  break
fi
done

exit 0
