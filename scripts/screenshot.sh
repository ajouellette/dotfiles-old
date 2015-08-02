#!/bin/bash
# take a screenshot

file=~/Pictures/$(date +%y%m%d-%H%M%S).png
maim -s --showcursor -b 3 $file

notify-send -u low "Screenshot saved to ~/Pictures"
