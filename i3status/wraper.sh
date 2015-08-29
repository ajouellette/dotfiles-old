#!/bin/sh
# wrap i3status and i3status.py

i3status | while :
do
    read line
    echo $(~/.config/i3status/i3status.py $line)
done

