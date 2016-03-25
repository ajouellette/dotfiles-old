#!/usr/bin/env bash
# i3 (or sway) lock script: pixelates screen and adds lock icon
# requires imagemagick and scrot (for i3)

icon="$HOME/Pictures/icons/lock-icon.png"
tmpbg="/tmp/lockscreen.png"
text="/tmp/locktext.png"

# detect what WM is being used
if [ -n "$SWAYSOCK" ]; then
    wm='sway'
else
    wm='i3'
fi

# pause notifications
killall -SIGUSR1 dunst

# get image
if [ "$wm" == "i3" ]; then
    scrot "$tmpbg"
else
    swaygrab "$tmpbg"
fi

convert "$tmpbg" -scale 10% -scale 1000% -fill black -colorize 25% "$tmpbg"

# add lock icon
if [ -f "$icon" ]; then
    convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
fi

# add text
[ -f $text ] || {
    convert -size 3000x60 xc:white -font Droid-Sans -pointsize 26 -fill black -gravity center -annotate +0+0 'Type password to unlock' $text;
    convert $text -alpha set -channel A -evaluate set 50% $text;
}
convert $tmpbg $text -gravity center -geometry +0+200 -composite $tmpbg

# lock, don't fork (to work with xss-lock)
if [ "$wm" == "i3" ]; then
    i3lock -n -e -i "$tmpbg"
else
    swaylock -i "$tmpbg"
fi

# resume notifications
killall -SIGUSR2 dunst


# blur command (slower)
#i3lock -d "$@" -i <(import -window root - | convert -blur -2x5 - png:-)
