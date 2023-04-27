function dlf!() {
  while true; do
    while ! docker container logs --follow "$@"; do
      sleep 1
      echo -e -n '\e[1A\e[K'
    done

    sleep 2
  done
}

alias dci="docker container inspect"
alias dclc="docker container ls --all --format \"table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}\""
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
alias dvp!="docker volume prune --force"
alias dvpa="docker volume prune --filter all=1"
alias dvpa!="docker volume prune --filter all=1 --force"

alias dsp="docker system prune"
alias dsp!="docker system prune --force"
alias dspv="docker system prune --volumes"
alias dspv!="docker system prune --force --volumes"
alias dpa="docker system prune --volumes; docker volume prune --filter all=1"
alias dpa!="docker system prune --force --volumes; docker volume prune --filter all=1 --force"
