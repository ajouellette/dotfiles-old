# zsh aliases

alias c='clear'
alias x='exit'

# ls aliases
alias ls='ls -h --color=auto --group-directories-first'
alias la='ls -A'
alias ll='ls -lAF'

alias grep='grep --color=auto'
alias gdb='gdb -q'

# make rm safer
alias rm='rm -Iv --one-file-system'

# confirm when overwriting files
alias cp='cp -iv'
alias mv='mv -iv'
alias ln='ln -iv'

alias du='du -h'
alias df='df -h'

# pretty print path
alias path='echo -e ${PATH//:/\\n}'

# go back
alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'

# runs vim as user instead of as root (safer)
alias svim='sudoedit'
# a minimal vim configuration
if [ -f ~/.vimrc.min ]; then
    alias vi='vim -u ~/.vimrc.min'
fi

alias bc='bc -q -l'
alias calc='python -qi -c "from math import *"'

alias kernel='uname -rs'
alias up='uptime -p'

#alias ncmpcpp='ncmpcpp -c ~/.config/ncmpcpp/config'
alias mutt='mutt -F ~/.config/mutt/muttrc'

# extract archives
extract () {
     if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1;;
            *.tar.gz)    tar xvzf $1;;
            *.bz2)       bunzip2 $1;;
            *.rar)       unrar x $1;;
            *.gz)        gunzip $1;;
            *.tar)       tar xvf $1;;
            *.tbz2)      tar xvjf $1;;
            *.tgz)       tar xvzf $1;;
            *.zip)       unzip $1;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1;;
            *)           echo "don't know how to extract '$1'...";;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# stow commands
alias stow='stow --verbose=1'
alias unstow='stow --delete'
alias restow='stow --restow'

alias getip='curl icanhazip.com'

alias rfortune='fortune | cowsay -f $(find /usr/share/cows -type f | shuf -n 1)'

# print top 10 most used commands
alias top10="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# if mutt is already running, launch read-only
mut() {
    if [ -n "$(pgrep mutt)" ]; then
        mutt -R
    else
        mutt
    fi
}

#####################################
##        Arch aliases             ##
#####################################
# pacman aliases and functions:
# enable etckeeper when installing/upgrading
Pacman() { sudo etckeeper pre-install && sudo pacman "$@" && sudo etckeeper post-install; }
Pacaur() { sudo etckeeper pre-install && pacaur "$@" && sudo etckeeper post-install; }
Pacmatic() { sudo etckeeper pre-install && sudo pacmatic "$@" && sudo etckeeper post-install; }

alias install='Pacaur -S --needed'
alias search="pacman -Ss"
alias searchaur="pacaur -s"

update() {
    sudo etckeeper pre-install && \
    sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && \
    sudo reflector -l 30 -c "United States" -c "Canada" -f 10 -p http --sort rate --verbose --save /etc/pacman.d/mirrorlist && \
    sudo pacmatic -Syuu && \
    pacaur -u && \
    sudo etckeeper post-install
}

upgrade() {
    sudo etckeeper pre-install && \
    sudo pacmatic -Syu && \
    pacaur -u && \
    sudo etckeeper post-install
}

pacinfo() {
    pacman -Qi "$1" &> /dev/null
    if [ "$?" -eq 1 ]
    then
        pacaur -Si "$1"
    else
        pacman -Qi "$1"
    fi
}
# clean package cache
clean-cache() {
    paccache -r
    paccache -ruk0
}
# remove orphaned packages
remove-orphans() {
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphaned packages to remove."
    else
        Pacman -Rns $(pacman -Qdtq)
    fi
}
alias clean='remove-orphans; clean-cache; sudo pacman-optimize'
alias remove='Pacman -Rns'
# sort installed packages by size
pacsort() {
    expac -s "%-30n %m" | sort -hk 2 | awk '{print $1, $2/1024/1024}' | column -t | less
}
# list all explicitely installed packages, not in base or base-devel
lsinstalled() {
    expac -HM "%011m\t%-20n\t%10d" $( comm -23 <(pacman -Qqen|sort) <(pacman -Qqg base base-devel|sort) ) | sort -n | less
}


####################
#  System          #
####################
alias reboot='systemctl reboot'
alias shutdown='systemctl poweroff'
alias hibernate='systemctl hibernate'
alias journal='journalctl -r'
# find broken links
broken-links() {
    sudo find . -type l -! -exec test -e {} \; -print
}

