# ~/.profile

# Java fonts
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

# set up config/cache dirs
[ "$XDG_CACHE_HOME" ] || export XDG_CACHE_HOME="$HOME/.cache"
[ "$XDG_CONFIG_HOME" ] || export XDG_CONFIG_HOME="$HOME/.config"
[ "$XDG_DATA_HOME" ] || export XDG_DATA_HOME="$HOME/.local/share"

# dircolors
source <(dircolors -b <(cat "$XDG_CONFIG_HOME"/dircolors/*.conf))

# make applications respect those dirs
export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks
export GIMP2_DIRECTORY="$XDG_CONFIG_HOME"/gimp
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"
export MPLAYER_HOME="$XDG_CONFIG_HOME"/mplayer
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
export WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export ATOM_HOME="$XDG_DATA_HOME/atom"

export DVDCSS_CACHE="$XDG_CACHE_HOME"/dvdcss
export LESSHISTFILE="$XDG_CACHE_HOME"/less/hist

# colors for less
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/devel/go/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.2.0/bin:$PATH"
export PATH="$HOME/.npm_modules/bin:$PATH"

# go path
export GOPATH="$HOME/devel/go"

