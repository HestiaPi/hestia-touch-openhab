#!/bin/bash

FILE=/home/pi/scripts/gitinstalledversion
if test -f "$FILE"; then
  cat /home/pi/scripts/gitinstalledversion;
else
  echo "No version info found."
fi

exit 0;
