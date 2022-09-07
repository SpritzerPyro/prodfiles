bindkey -v

bindkey -M vicmd '^R' redo
bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line
bindkey -M vicmd 'u' undo
bindkey -M vicmd 'Y' vi-yank-eol

bindkey ' ' magic-space
bindkey '^[[1~' beginning-of-line
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey '^R' history-incremental-search-backward
bindkey '^X' edit-command-line
bindkey "^?" backward-delete-char
bindkey "^N" down-line-or-history
bindkey "^P" up-line-or-history
