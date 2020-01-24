#!/bin/bash

FILE=/home/pi/scripts/backup.zip
OLDFILE=/home/pi/backup.zip
if test -f "$FILE"; then
  if test -f "$OLDFILE"; then
    sudo rm $OLDFILE
  fi
  sudo cp $FILE $OLDFILE
  sudo reboot;
else
    echo "No backup found."
fi
exit;
