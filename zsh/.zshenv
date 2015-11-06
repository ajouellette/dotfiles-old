# zsh environment

which exo-open > /dev/null
if [ $? = 0 ]; then
    export DE=xfce
fi


if [[ $TERM == xterm ]]; then
    export TERM=xterm-256color
fi

# use gtk style for qt5
export QT_STYLE_OVERRIDE=GTK+

# pacmatic config
# add these variables to env_keep in /etc/sudoers
#export pacman_program="sudo -u aaron /usr/bin/pacaur"

# make programs use proper config/cache dirs
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

