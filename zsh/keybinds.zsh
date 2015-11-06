# zsh keybinds

# vi in the shell is too confusing
bindkey -e
# searching history
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward
# edit command in editor
bindkey "^F" edit-command-line
# resume vim after suspending
bindkey '^Z' foreground-vi
