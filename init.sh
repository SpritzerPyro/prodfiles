: "${PRODFILES_DIR:="$(dirname "$(readlink -f "${0}")")"}"

: "${ZSH:="${HOME}/.oh-my-zsh"}"
: "${ZSH_CUSTOM:="${PRODFILES_DIR}/zsh"}"
: "${ZSH_THEME:="cautionary"}"

: "${DISABLE_UNTRACKED_FILES_DIRTY:="true"}"
: "${EDITOR:="vim"}"
: "${HIST_STAMPS:="yyyy-mm-dd"}"
: "${TERM:="xterm-256color"}"

if [[ "${TERM}" == "tmux-256color" ]]; then
  TERM="xterm-256color"
fi

for _i in "${plugins[@]}"; do
  if [[ -f "${ZSH_CUSTOM}/plugins/_${_i}/_${_i}.plugin.zsh" ]]; then
    plugins+=("_${_i}")
  fi
done

unset _i

source "${ZSH}/oh-my-zsh.sh"
