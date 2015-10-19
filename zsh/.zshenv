# zsh environment

# path variable set in .zshrc

# go path
export GOPATH="$HOME/.go"

# make Java fonts better
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

# default programs
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export PAGER=/usr/bin/less

if [ -n "$DISPLAY" ]; then
    export BROWSER=/usr/bin/firefox
else
    export BROWSER=/usr/bin/elinks
fi

which exo-open > /dev/null
if [ $? = 0 ]; then
    export DE=xfce
fi

# Coloring less command
export LESS=-R
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

if [[ $TERM == xterm ]]; then
    export TERM=xterm-256color
fi

# use gtk style for qt5
export QT_STYLE_OVERRIDE=GTK+

# pacmatic config
# add these variables to env_keep in /etc/sudoers
export pacman_program="sudo -u aaron /usr/bin/pacaur"

# make programs use proper config/cache dirs
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share

export LESSHISTFILE=-
export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks

