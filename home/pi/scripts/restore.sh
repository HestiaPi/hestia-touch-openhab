#!/bin/bash

FILE=/home/pi/scripts/backup.zip
if test -f "$FILE"; then
  sudo rm /home/pi/backup.zip
  sudo cp $FILE /home/pi/backup.zip
  sudo reboot;
else
    echo "No backup found."
fi
exit;
