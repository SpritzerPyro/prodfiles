function td() {
  local flag OPTARG OPTIND
  local _prefix

  while getopts 'p:' flag; do
    case "${flag}" in
      p) _prefix="${OPTARG}" ;;
      *) { echo "Invalid option provided" >&2; exit 1; } ;;
    esac
  done

  shift $(( OPTIND - 1 ))

  local _absolute_path _dir_name _session_name

  _absolute_path=$(readlink -f "${1:-.}")
  _dir_name=$(basename "${_absolute_path}")
  _session_name="${_dir_name//./-}"

  if [[ "${_prefix}" ]]; then
    _session_name="${_prefix}-${_session_name}"
  fi

  if tmux has-session -t "${_session_name}" &>/dev/null; then
    tmux attach -t "${_session_name}"
  else
    tmux new -c "${_absolute_path}" -n root -s "${_session_name}"
  fi
}
