function dlf!() {
  if ! docker container logs --follow "$@"; then
    sleep 2
    echo -e -n '\e[1A\e[K'
    dlf! "$@"
  fi

  sleep 4
  dlf! "$@"
}

alias dci="docker container inspect"
alias dclc="docker container ls --all --format \"table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\""
alias dcp!="docker container prune --force"
alias dcp="docker container prune"
alias dr='docker container run --rm'
alias drit='docker container run --interactive --rm --tty'
alias dxc='docker container exec'
alias dxcit='docker container exec --interactive --tty'

alias dlv="docker container logs --details --timestamps"
alias dlf="docker container logs --follow"
alias dlfv="docker container logs --details --follow --timestamps"
alias dlfv!="dlf! --details --timestamps"

alias dip="docker image prune"
alias dip!="docker image prune --force"

alias dnp="docker network prune"
alias dnp!="docker network prune --force"

alias dvp="docker volume prune"
alias dvp!="docker volume prune!"

alias dsp="docker system prune"
alias dsp!="docker system prune --force"
alias dspv="docker system prune --volumes"
alias dspv!="docker system prune --force --volumes"

compdef _docker_logs dlf! dlfv!
