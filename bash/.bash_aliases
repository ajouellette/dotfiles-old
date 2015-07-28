#
# ~/.bash_aliases
#	
################################
#### Alias definitions.   ######
################################
alias bashrc='vim ~/.bashrc && source ~/.bashrc'

# ls aliases
alias ls='ls -h --color'
alias la='ls -A'
alias ll='ls -lAF'

alias grep='grep --color=auto'

# make rm safer
alias rm='rm -Iv'

# confirm when overwriting files
alias cp='cp -i'
alias mv='mv -i'

# pretty print path
alias path='echo -e ${PATH//:/\\n}'

# go back
alias ..='cd ..'

extract () {       # function to extract many types of archives
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

# Arch aliases
# pacman aliases and functions:
alias install='sudo pacman -S --needed'
alias update='sudo cp mirrorlist mirrorlist.bak && sudo reflector -l 30 -c "United States" -c Canada -f 10 --sort rate --verbose --save /etc/pacman.d/mirrorlist && sudo pacman -Syyu'
clean-cache() {                           # clean package cache
    paccache -r
    paccache -ruk0
}
remove-orphans() {                        # function to remove orphaned packages
    if [[ ! -n $(pacman -Qdt) ]]; then
        echo "No orphaned packages to remove."
    else
        sudo pacman -Rns $(pacman -Qdtq)
    fi
}
alias clean='remove-orphans && clean-cache && sudo pacman-optimize'
broken-links() {
	 sudo find . -type l -! -exec test -e {} \; -print
}

top10() {
	history | awk 'BEGIN {FS="[ \t]+|\\|"} {print $3}' | sort | uniq -c | sort -nr | head
}
