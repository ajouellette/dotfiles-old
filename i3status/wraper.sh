#!/bin/sh
# shell script to prepend i3status with more stuff

i3status | while :
do
    read line
    
    # backlight
    brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
    max_bright=$(cat /sys/class/backlight/intel_backlight/max_brightness)
    percent=$(($brightness*100/$max_bright))
    
    # kernel
    kernel=$(uname -rs)

    # output
    echo " $kernel   $percent%  $line" || exit 1
done
