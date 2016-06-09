# zsh environment

which exo-open > /dev/null
if [ $? = 0 ]; then
    export DE=xfce
fi


if [[ $TERM == xterm ]]; then
    export TERM=xterm-256color
fi

# make programs use proper config/cache dirs
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

