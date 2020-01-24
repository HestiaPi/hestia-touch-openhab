#!/bin/bash

FILE=/home/pi/scripts/backup.zip
if test -f "$FILE"; then
  date -r /home/pi/scripts/backup.zip +"%F %H:%M";
else
  echo "No backup found."
fi

exit;
