#!/bin/bash
#
# This script will turn off the LCD backlight when DPMS turns off the monitor
# and turns the backlight back on when DPMS turns the monitor back on.
#
export DISPLAY=:0
PIN=15

# Make sure DPMS (energy saving) is on
xset +dpms

# Set pins as output
raspi-gpio set $PIN op

# Start with the pin HIGH. If the pin goes LOW, the backlight will turn off
raspi-gpio set $PIN dh

# Get the current state of the monitor
CURRENT_STATUS=$(xset q | grep "Monitor is" | awk '{print $3}')
LAST_STATUS=$CURRENT_STATUS
logger -p info -t "backlight_service" -s "Monitor is $CURRENT_STATUS"

# Loop indefinitely updating backlight in sync with monitor status
while true; do
	# Check the current monitor status
	CURRENT_STATUS=$(xset q | grep "Monitor is" | awk '{print $3}')
	# Only turn the backlight on/off if the Monitor state has changed
	if [ "$CURRENT_STATUS" != "$LAST_STATUS" ]; then
		logger -p info -t "backlight_service" -s "Monitor is $CURRENT_STATUS"
		# Control backlight pin according to the monitor status
		if [ "$CURRENT_STATUS" = "On" ]; then
			logger -p info -t "backlight_service" -s "Turning Backlight On"
			raspi-gpio set $PIN dh
		else
			logger -p info -t "backlight_service" -s "Turning Backlight Off"
			raspi-gpio set $PIN dl
		fi
		LAST_STATUS=$CURRENT_STATUS
	fi
	# Sleep before checking again
	sleep 1s
done
