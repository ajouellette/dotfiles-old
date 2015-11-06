# ~/.profile

# Java fonts
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

# dircolors
source <(dircolors -b <(cat "$HOME/.config/dircolors"/*.conf))

# config and cache dirs
export ELINKS_CONFDIR=~/.config/elinks
export GIMP2_DIRECTORY=~/.config/gimp
export INPUTRC=~/.config/readline/inputrc
export DVDCSS_CACHE=~/.config/dvdcss
export LESSHISTFILE=~/.cache/less/hist

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
export PATH="$HOME/.go/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.2.0/bin:$PATH"

# go path
export GOPATH="$HOME/.go"

