# shellcheck disable=SC2139

# Aptitude

function apt_test_installed() {
  dpkg-query -Wf'${db:Status-abbrev}' "$1" 2>/dev/null | grep -q '^i'
}

function apt_update_all () {
  local _apt_cmd _sudo_cmd

  [[ "${commands[apt]:-}" ]] && _apt_cmd="apt" || _apt_cmd="apt-get"
  [[ "${commands[sudo]:-}" ]] && _sudo_cmd="sudo " || _sudo_cmd=""

  apt_test_installed "${_apt_cmd}" || return 0

  eval "${_sudo_cmd}${_apt_cmd} update $*"
  eval "${_sudo_cmd}${_apt_cmd} upgrade --with-new-pkgs $*"
  eval "${_sudo_cmd}${_apt_cmd} dist-upgrade $*"
  eval "${_sudo_cmd}${_apt_cmd} autoremove $*"
  eval "${_sudo_cmd}${_apt_cmd} autoclean $*"
}

alias apu!="apt_update_all --yes"
alias apu="apt_update_all"
alias ati="apt_test_installed"

# Snap

function snap_install() {
  local _apt_cmd _sudo_cmd

  [[ "${commands[apt]:-}" ]] && _apt_cmd="apt" || _apt_cmd="apt-get"
  [[ "${commands[sudo]:-}" ]] && _sudo_cmd="sudo " || _sudo_cmd=""

  if ! apt_test_installed "${_apt_cmd}"; then
    echo "Command '${_apt_cmd}' not found" >&2
    return 1
  fi

  eval "${_sudo_cmd}rm --force /etc/apt/preferences.d/nosnap.pref"
  eval "${_sudo_cmd}${_apt_cmd} update"
  eval "${_sudo_cmd}${_apt_cmd} install snapd --yes"
}

function snap_update() {
  local _sudo_cmd

  [[ "${commands[sudo]:-}" ]] && _sudo_cmd="sudo " || _sudo_cmd=""

  if ! apt_test_installed snapd; then
    echo "The snap daemon is not installed."
    echo "To install snap execute \"snap_install\""

    return
  fi

  local snapname revision

  eval "${_sudo_cmd}snap refresh"

  LANG=C snap list --all | awk '/disabled/{ print $1, $3 }' |
    while read -r snapname revision; do
        eval "${_sudo_cmd}snap remove ${snapname} --revision=${revision}"
    done
}

alias sup="snap_update"

# Joint operations

alias upa="apt_update_all; snap_update; omd update"
alias upa!="apt_update_all --yes; snap_update; omz update"
