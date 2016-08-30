# zsh environment

which exo-open > /dev/null
if [ $? = 0 ]; then
    export DE=xfce
fi


if [[ $TERM == xterm ]]; then
    export TERM=xterm-256color
fi

# source ~/.profile
emulate sh -c 'source ~/.profile'

