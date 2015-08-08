# start bspwm
# source this from xinitrc

# pulseaudio
start-pulseaudio-x11 &

# compositor and wallpaper
compton &
nitrogen --restore &

sxhkd &
exec bspwm
