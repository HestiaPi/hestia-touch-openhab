#!/bin/bash

# Copied from https://www.raspberrypi.org/forums/viewtopic.php?f=29&t=174434&start=25#p1307919
# Expand the filesystem if < 3.5 GB
PARTSIZE=$( df | sed -n '/root/{s/  */ /gp}' | cut -d ' ' -f2 )
THRESHOLD=3679731

if (("$PARTSIZE" < "$THRESHOLD")) ; then
    sudo raspi-config --expand-rootfs && reboot
fi
# If backup file exists after boot restore, delete it and reboot
if [ -f /home/pi/backup.zip ]; then
  sudo service openhab2 stop && yes | sudo openhab-cli restore /home/pi/backup.zip && sudo rm /home/pi/backup.zip;
  sudo reboot;
fi
# If rules file exists after boot, hide it until openHAB loads fully
if [ -f /etc/openhab2/rules/default.rules ]; then
  sudo mv /etc/openhab2/rules/default.rules /home/pi/scripts/default.rules;
fi
yes | sudo /usr/bin/openhab-cli reset-ownership;

while :
do
  if [ "$(pidof Xorg)" ]
  then
  echo "Xorg running...";

  # Clean up previously running apps, gracefully at first then harshly
  killall -TERM matchbox-window-manager 2>/dev/null;
  echo "Matchbox terminated";
  sleep 2;

  killall -9 matchbox-window-manager 2>/dev/null;
  echo "Final termination of Matchbox";

  # Clean out existing profile information
  echo "Removing old pi config...";
  rm -rf /home/pi/.cache;
  rm -rf /home/pi/.config;
  rm -rf /home/pi/.pki;

  # Disable DPMS / Screen blanking
  echo "Starting xset with opts...";
  xset -dpms
  xset -nocursor
  xset s off

  # Reset the framebuffer's colour-depth
  echo "Resetting the framebuffer's depth...";
  fbset -depth $( cat /sys/module/*fb*/parameters/fbdepth );

  # Hide the cursor (move it to the bottom-right, comment out if you want mouse interaction)
  echo "Moving cursor to bottom right...";
  xwit -root -warp $( cat /sys/module/*fb*/parameters/fbwidth ) $( cat /sys/module/*fb*/parameters/fbheight )

  # Start the window manager (remove "-use_cursor no" if you actually want mouse interaction)
  echo "Starting matchbox in a bit...";
  matchbox-window-manager -use_titlebar no -use_cursor no &


  model=$(cat /proc/cpuinfo | grep "ARMv6" | wc -l)
  if [ $model -ne 1 ]; then
    # This is a fast Pi, wait for WiFi to start
    sleep 10;
  fi

  distro=$(sed 's/\..*//' /etc/debian_version)
  if [ $distro -ge 9 ]; then
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
  # Show IP and MAC
  cp /home/pi/scripts/openhabloader.blank.html /home/pi/scripts/openhabloader.html
  sed -i -e "s/wlanip/$wlanip/g" /home/pi/scripts/openhabloader.html
  sed -i -e "s/wlanmac/$wlanmac/g" /home/pi/scripts/openhabloader.html
  # Show HESTIAPI WiFi network instructions on loading screen
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

  # Run unclutter
  unclutter &

  # Start the browser (See http://peter.sh/experiments/chromium-command-line-switches/)
  echo "Starting kweb...";

  kweb -KJ /home/pi/scripts/openhabloader.html &

  sleep 20;
  while :
  do
    if (($(echo "$(top -b -n1 | grep "load average:" | awk '{print $(NF-2)}' | cut -d, -f1) > 2.00" | bc -l))); then
      echo 'Too busy'
      sleep 10; #Check again later
    else
      echo "Not too busy. Load!"
      if [ ! -f /etc/openhab2/rules/default.rules ]; then
        # Load full UI

        # Run unclutter
        unclutter &

        echo "Easy Startup found. Loading UI...";
        sudo -u openhab cp /home/pi/scripts/default.rules /etc/openhab2/rules/default.rules;

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
          kweb -KJ /home/pi/scripts/oneui/index.html
          sleep 10;
        done
      fi
      break;
    fi
  done

  else
    echo "Xorg not running. Retrying...";
    sleep 1;
  fi
done
