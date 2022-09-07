[[ "${commands[apt]:-}" ]] && _apt_cmd=apt || _apt_cmd=apt-get

echo "${_apt_cmd}"

function snu() {
  local snapname revision

  sudo snap refresh

  LANG=C snap list --all | awk '/disabled/{ print $1, $3 }' |
    while read -r snapname revision; do
        sudo snap remove "${snapname}" --revision="${revision}"
    done
}

alias snid='sudo rm --force /etc/apt/preferences.d/nosnap.pref; sudo ${_apt_cmd} update; sudo ${_apt_cmd} install snapd --yes'

alias apu='sudo ${_apt_cmd} update; sudo ${_apt_cmd} upgrade --with-new-pkgs; sudo ${_apt_cmd} dist-upgrade; sudo ${_apt_cmd} autoremove; sudo ${_apt_cmd} autoclean'
alias apu!='sudo ${_apt_cmd} update; sudo ${_apt_cmd} upgrade --with-new-pkgs --yes; sudo ${_apt_cmd} dist-upgrade --yes; sudo ${_apt_cmd} autoremove --yes; sudo ${_apt_cmd} autoclean --yes'

alias upa='apu; snu; omd update'
alias upa!='apu!; snu; omd update'
