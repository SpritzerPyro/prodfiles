if is_plugin "${ZSH}" tmux; then
  source "${ZSH}/plugins/tmux/tmux.plugin.zsh"
fi

function td() {
  local _absolute_path _dir_name _session_name

  _absolute_path=$(readlink -f "${1:-.}")
  _dir_name=$(basename "${_absolute_path}")
  _session_name="${_dir_name//./-}"

  if tmux has-session -t "${_session_name}" &>/dev/null; then
    tmux attach -t "${_session_name}"
  else
    tmux new -c "${_absolute_path}" -n root -s "${_session_name}"
  fi
}
