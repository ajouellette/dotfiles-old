#!/usr/bin/env bash
# take a screenshot of selected area
# requires maim, slop

file=~/Pictures/$(date +%y%m%d-%H%M%S).png
maim -s --showcursor -b 3 $file

notify-send -u low "Screenshot saved to ~/Pictures"

