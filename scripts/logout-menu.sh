#!/bin/bash
CMD=`echo -e "Lock\nSuspend\nLogout\nReboot\nShutdown" | rofi -dmenu -p "Logout Menu: "`
if [ ! $CMD ]; then
    exit
fi

case $CMD in
    Logout)
        i3-msg exit ;;
    Lock)
        ~/.bin/i3lock.sh ;;
    Shutdown)
        systemctl poweroff -i;;
    Reboot)
        systemctl reboot ;;
    Suspend)
        systemctl suspend ;;
esac
