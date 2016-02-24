# start i3 window manager 
# source this script from xinitrc

# pulseaudio
start-pulseaudio-x11 &

# authentication agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# compositor and wallpaper
compton &
nitrogen --restore &

# start i3
exec i3
