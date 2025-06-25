function dlf!() {
  local _dlf_flag
  _dlf_flag=0

  while true; do
    if docker container inspect "$1" &>/dev/null; then
      echo "Attaching logs for container '$1'..."
      echo "================================================================================"
      docker logs --follow "$@" 2>&1
      echo "================================================================================"
      echo "Container '$1' has stopped. Waiting to reattach..."
    elif ((!${_dlf_flag})); then
      _dlf_flag=1
      echo "Container '$1' does not exist. Waiting for it to be created..."
    fi

    sleep 1
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
alias dpa="docker system prune --volumes; docker volume prune --all --filter label!=protected"
alias dpa!="docker system prune --force --volumes; docker volume prune --all --filter label!=protected --force"
