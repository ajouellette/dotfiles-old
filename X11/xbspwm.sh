# start bspwm
# source this from xinitrc

# pulseaudio
start-pulseaudio-x11 &

# compositor and wallpaper
compton &
nitrogen --restore &

# fix cursor
xsetroot -cursor_name left_ptr

sxhkd &
exec bspwm
