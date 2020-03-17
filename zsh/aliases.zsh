# zsh aliases

alias zshrc="$EDITOR $ZDOTDIR/.zshrc; source $ZDOTDIR/.zshrc"

alias c='clear'
alias x='exit'

# ls aliases
alias ls='ls -hv --group-directories-first --color=always'
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

# better ln
# sln LINK_NAME TARGET: symlink from file TARGET to file LINK_NAME
sln() {
    ln -s $2 $1
}

# renaming files
alias mmv='zmv -iW'

alias du='du -h'
alias df='df -h'
alias lsblk='lsblk --output "NAME,TYPE,LABEL,SIZE,FSTYPE,MOUNTPOINT"'

# pretty print path
alias path='echo -e ${PATH//:/\\n}'

# go back
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# runs vim as user instead of as root (safer)
alias svim='sudoedit'
# a minimal vim configuration
if [ -f ~/.config/nvim/minimal.vim ]; then
    alias vi='nvim -u ~/.config/nvim/minimal.vim'
fi
alias vim='nvim'

alias calc='python -qi -c "from math import *"'

alias wrpi='mpv --no-video http://icecast1.wrpi.org:8000/mp3-256.mp3.m3u'

alias kernel='uname -rs'
alias up='uptime -p'

alias mutt='mutt -F ~/.config/mutt/muttrc'
alias tmux='tmux -f ~/.config/tmux/tmux.conf'

# use hub (extra commands for GitHub) if installed
if [[ -z $(which hub | grep "not found") ]]; then
    alias git='hub'
fi

# cd into a new dir
mkcd () {
    local dir="$1"; shift
    mkdir "$dir" "$@" && cd "$dir"
}

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

alias open='xdg-open'

# wine 32/64 bit
alias wine32='WINEARCH=win32 WINEPREFIX=~/win32 wine'
alias wine64='WINEARCH=win64 WINEPREFIX=~/win64 wine'

alias matlab='matlab -nodesktop -nosplash'

# Arch aliases
if [ -n "$(grep "Arch Linux" /etc/os-release)" ]; then
    # pacman aliases and functions:
    alias install='yay -S --needed'
    alias search="pacman -Ss"
    alias searchaur="yay -Ss --aur"

    update() {
        sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak && \
        sudo reflector -l 30 -c "United States" -c "Canada" -f 10 -p http --sort rate --verbose --save /etc/pacman.d/mirrorlist && \
        sudo pacman -Fy && \
        yay -Syyu
    }

    alias upgrade='yay -Syu'

    pacinfo() {
        pacman -Qi "$1" &> /dev/null
        if [ "$?" -eq 1 ]
        then
            yay -Si "$1"
        else
            pacman -Qi "$1"
        fi
    }
    # clean package cache
    clean-cache() {
        paccache -r -c /var/cache/aur/pkg -c /var/cache/pacman/pkg   # work around bug FS#47024
        paccache -ruk0 -c /var/cache/aur/pkg -c /var/cache/pacman/pkg
    }
    # remove orphaned packages
    remove-orphans() {
        if [[ ! -n $(pacman -Qdt) ]]; then
            echo "No orphaned packages to remove."
        else
            sudo pacman -Rns $(pacman -Qdtq)
        fi
    }
    alias clean='sudo pacdiff; remove-orphans; clean-cache'
    alias remove='sudo pacman -Rns'
    # sort installed packages by size
    pacsort() {
        expac -s "%-30n %m" | sort -hk 2 | awk '{print $1, $2/1024/1024}' | column -t | less
    }
    # list all explicitely installed packages, not in base or base-devel
    lsinstalled() {
        expac -HM "%011m\t%-20n\t%10d" $( comm -23 <(pacman -Qqe|sort) <(pacman -Qqg base base-devel|sort) ) | sort -n | less
    }
fi


#  System
alias reboot='systemctl reboot'
alias shutdown='systemctl poweroff'
alias hibernate='systemctl hibernate'
alias journal='journalctl -r'

# find broken links
broken-links() {
    sudo find . -type l -! -exec test -e {} \; -print
}

