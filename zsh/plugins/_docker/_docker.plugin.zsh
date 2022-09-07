function dlof!() {
  if ! docker container logs --follow "$@"; then
    sleep 2
    echo -e -n '\e[1A\e[K'
    dlof! "$@"
  fi

  sleep 4
  dlof! "$@"
}

alias dclc="docker container ls --all --format \"table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\""
alias dr='docker container run --rm'
alias drit='docker container run --interactive --rm --tty'
alias dxc='docker container exec'
alias dxcit='docker container exec --interactive --tty'

alias dlov="docker container logs --details --timestamps"
alias dlof="docker container logs --follow"
alias dlofv="docker container logs --details --follow --timestamps"
alias dlofv!="dlof! --details --timestamps"
