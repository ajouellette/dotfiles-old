#!/bin/bash
# a logout menu using rofi

CMD=`echo -e "Suspend\nLogout\nReboot\nHibernate\nShutdown" | rofi -dmenu -p "Logout Menu:" -lines 6 -width 100 -padding 500`

if [ ! $CMD ]; then
    exit
fi

case $CMD in
    Logout)
        i3-msg exit ;;
    Shutdown)
        systemctl poweroff -i;;
    Reboot)
        systemctl reboot ;;
    Hibernate)
        systemctl hibernate ;;
    Suspend)
        systemctl suspend ;;
esac
