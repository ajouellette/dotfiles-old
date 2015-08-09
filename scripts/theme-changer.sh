#!/bin/bash
# a script to change themes using rofi

CMD=`echo -e "$(ls -1 ~/theme-changer/themes)" | rofi -dmenu -p "Select Theme:"`
if [ ! $CMD ]; then
    exit
fi

cmd=$(echo ~/theme-changer/apply-theme ~/theme-changer/themes/"$CMD")
eval $cmd
