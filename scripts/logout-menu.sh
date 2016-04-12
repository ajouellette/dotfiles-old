#!/usr/bin/env bash
# a logout menu using rofi

# try to autodetect WM
if [ -n "$SWAYSOCK" ]; then
    wm='sway'
elif [ -n "$I3SOCK" ]; then
    wm='i3'
else
    wm=${1:-i3}
fi

CMD=`echo -e "Suspend\nLogout\nReboot\nHibernate\nShutdown" | rofi -dmenu -p "Logout Menu:" -lines 6`

case $wm in
    i3)
        logout="i3-msg exit";;
    bspwm)
        logout="bspc quit";;
    sway)
        logout="swaymsg exit";;
    *)
        logout="";;
esac


if [ ! $CMD ]; then
    exit
fi

case $CMD in
    Logout)
        eval "$logout";;
    Shutdown)
        systemctl poweroff -i;;
    Reboot)
        systemctl reboot;;
    Hibernate)
        systemctl hibernate;;
    Suspend)
        systemctl suspend;;
esac


