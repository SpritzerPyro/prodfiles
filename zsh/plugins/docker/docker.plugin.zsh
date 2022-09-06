if is_plugin "${ZSH}" docker; then
  source "${ZSH}/plugins/docker/docker.plugin.zsh"
fi

alias dclc="docker container ls --all --format \"table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\""
alias dr='docker container run --rm'
alias drit='docker container run --interactive --rm --tty'
alias dxc='docker container exec'
alias dxcit='docker container exec ---interactive --tty'
