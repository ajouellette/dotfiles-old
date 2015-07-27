#!/bin/bash
# this script toggles automatic screen blanking and suspend
# useful when watching videos, for example

# get dpms status
DPMS=$(xset q | grep "DPMS is Disabled")

if [ "$DPMS" == "" ]; then
    # dpms enabed, turn it off
	xset s 0 0
	xset s noblank
	xset -dpms
    xautolock -disable
    echo "Caffeine mode enabled"
    # send notification
	notify-send -a "Caffeine" -i "caffeine" "Caffeine Mode Enabled"
else
    # dpms disabled, turn it on
	xset s 0 300
	xset s blank
	xset +dpms
    xautolock -enable
    echo "Caffeine mode disabled"
	notify-send -a "Caffeine" -i "caffeine" "Caffeine Mode Disabled"
fi;

