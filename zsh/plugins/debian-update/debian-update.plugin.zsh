# shellcheck disable=SC2139

function _apt_test_installed() {
  dpkg-query -Wf'${db:Status-abbrev}' "$1" 2>/dev/null | grep -q '^i'
}

function _apt_update_all() {
  local _apt_cmd _sudo_cmd

  command -v apt &>/dev/null && _apt_cmd="apt" || _apt_cmd="apt-get"
  command -v sudo &>/dev/null && _sudo_cmd="sudo " || _sudo_cmd=""

  _apt_test_installed "${_apt_cmd}" || return 0

  eval "${_sudo_cmd}${_apt_cmd} full-upgrade $*"
  eval "${_sudo_cmd}${_apt_cmd} autoremove $*"
  eval "${_sudo_cmd}${_apt_cmd} clean $*"
}

function _flatpak_update() {
  local _sudo_cmd

  command -v sudo &>/dev/null && _sudo_cmd="sudo " || _sudo_cmd=""

  if ! _apt_test_installed flatpak; then
    echo "Flatpak is not installed."
    return
  fi

  eval "${_sudo_cmd}flatpak update $*"
  eval "${_sudo_cmd}flatpak uninstall --unused $*"
  eval "${_sudo_cmd}flatpak repair"
}

function _snap_update() {
  local _sudo_cmd

  command -v sudo &>/dev/null && _sudo_cmd="sudo " || _sudo_cmd=""

  if ! _apt_test_installed snapd; then
    echo "The snap daemon is not installed."
    return
  fi

  local snapname revision

  eval "${_sudo_cmd}snap refresh"

  LANG=C snap list --all | awk '/disabled/{ print $1, $3 }' |
    while read -r snapname revision; do
      eval "${_sudo_cmd}snap remove ${snapname} --revision=${revision}"
    done
}

alias fup="_flatpak_update"
alias sup="_snap_update"
alias upa="_apt_update_all; _flatpak_update; _snap_update"
alias upa!="_apt_update_all --yes; _flatpak_update --assumeyes; _snap_update"
