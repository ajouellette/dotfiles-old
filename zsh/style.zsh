# zsh/style.zsh

# menu selection for completions
zstyle ':completion:*' menu select
# rehash
zstyle ':completion:*' rehash true
# show ambiguous character in bold red
zstyle ':completion:*' show-ambiguity "1;$color[fg-red]"
# use completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"

zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:functions' ignored-patterns '_*'

# apps
zstyle ':completion:*:*:(vim|gvim):*:*files' ignored-patterns \
    '*.(o|aux|out|pdf)'
zstyle ':completion:*:*:zathura:*:*' file-patterns \
    '*.(eps|ps|pdf|djvu):files *(-/):directories'
