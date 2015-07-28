#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# merge in Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

if [ "$1" = "xfce" ]; then
    startxfce4
else
    # disable caps lock key
    xmodmap ~/.Xmodmap &

    # enable screen blanking
    xset +dpms &
    xset dpms 0 0 240 &

    # start pulseaudio
    start-pulseaudio-x11 &

    # start authentication agent
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

    # compositor and wallpaper
    compton &
    nitrogen --restore &

    exec i3
fi
