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

# If rules file exists after boot, hide it until openHAB loads fully
if [ -f /etc/openhab2/rules/default.rules ]; then
  sudo mv /etc/openhab2/rules/default.rules /home/pi/scripts/default.rules;
fi
yes | sudo /usr/bin/openhab-cli reset-ownership;

model=$(cat /proc/cpuinfo | grep "ARMv6" | wc -l)
if [ $model -ne 1 ]; then
  # This is a fast Pi, wait for WiFi to start
  sleep 10;
fi

distro=$(sed 's/\..*//' /etc/debian_version)
if [ $distro -eq 9 ]; then
  wlan=$(/sbin/ifconfig wlan0 | grep inet\  | wc -l)
else
  wlan=$(/sbin/ifconfig wlan0 | grep inet\ addr | wc -l)
fi

wlanip="Not available"
wlanmac="Not available"

if [ $wlan -eq 0 ]; then
/sbin/ifdown wlan0 && /sbin/ifup wlan0
else
  wlanip=$(/home/pi/scripts/getwlan0ip.sh)
  wlanmac=$(/home/pi/scripts/getwlan0mac.sh)
fi

if [ -f /home/pi/scripts/openhabloader.html ]; then
  rm /home/pi/scripts/openhabloader.html
fi
cp /home/pi/scripts/openhabloader.blank.html /home/pi/scripts/openhabloader.html
sed -i -e "s/wlanip/$wlanip/g" /home/pi/scripts/openhabloader.html
sed -i -e "s/wlanmac/$wlanmac/g" /home/pi/scripts/openhabloader.html

if grep -q "hostapd" /home/pi/scripts/raspberry-pi-turnkey/status.json
then
    sed -i -e "s/none/block/g" /home/pi/scripts/openhabloader.html
else
    sed -i -e "s/block/none/g" /home/pi/scripts/openhabloader.html
fi

# Clean up previously running apps, gracefully at first then harshly
killall -TERM kweb 2>/dev/null;
echo "kweb terminated";
sleep 2;

killall -9 kweb 2>/dev/null;
echo "Final termination of kweb";

DISPLAY=:0 kweb -KJ /home/pi/scripts/openhabloader.html &
sleep 20;
while :
do
  if (($(echo "$(top -b -n1 | grep "load average:" | awk '{print $(NF-2)}' | cut -d, -f1) > 0.75" | bc -l))); then
    echo 'Too busy'
    sleep 10; #Check again later
  else
    echo "Not too busy. Load!"
    if [ ! -f /etc/openhab2/rules/default.rules ]; then
      # Load full UI

      echo "Easy Startup found. Loading UI...";
#      if [ -f /home/pi/scripts/default.rules ]; then
      sudo cp /home/pi/scripts/default.rules /etc/openhab2/rules/default.rules;
#      else
#        sudo cp /home/pi/scripts/hestiapi-one.rules /etc/openhab2/rules/default.rules;
#        # Read /home/pi/scripts/systemtype
#        if grep -Fxq "EU" /home/pi/scripts/systemtype
#        then
#            echo "EU Loaded.";
#            sudo cp /home/pi/scripts/generic.rules /etc/openhab2/rules/default.rules;
#        else
#            echo "Default US Loaded.";
#            sudo cp /home/pi/scripts/hvac.rules /etc/openhab2/rules/default.rules;
#        fi
#      fi
      sudo chmod 755 /etc/openhab2/rules/default.rules;
      sudo chown openhab:openhab /etc/openhab2/rules/default.rules;

      while :
      do
        # Start kweb if it dies and restart it
        # Clean up previously running apps, gracefully at first then harshly
        killall -TERM kweb 2>/dev/null;
        echo "kweb terminated";
        sleep 2;

        killall -9 kweb 2>/dev/null;
        echo "Final termination of kweb";

        # Start the browser
        echo "Starting kweb...";
        DISPLAY=:0 kweb -KJ /home/pi/scripts/oneui/index.html
        sleep 10;
      done
    fi
    break;
  fi
done
exit 0
