: "${PRODFILES:="$(dirname "$(readlink -f "${0}")")"}"

: "${ZSH:="${PRODFILES}/.oh-my-zsh"}"
: "${ZSH_CUSTOM:="${PRODFILES}/zsh"}"
: "${ZSH_THEME:="cautionary"}"

: "${DISABLE_UNTRACKED_FILES_DIRTY:="true"}"
: "${EDITOR:="vim"}"
: "${HIST_STAMPS:="yyyy-mm-dd"}"
: "${TERM:="xterm-256color"}"

if ! typeset -f prodfiles_danger_zone >/dev/null; then
  function prodfiles_danger_zone() {
    [[ "${SSH_CONNECTION:-}" ]]
  }
fi

: "${PRODFILES_DANGER_ZONE:="$(prodfiles_danger_zone && echo 1 || echo 0)"}"

if (( PRODFILES_DANGER_ZONE )); then
  : "${PRODFILES_DANGER_LEVEL:=2}"
fi

if [[ "${SSH_CONNECTION:-}" ]]; then
  : "${PRODFILES_DANGER_LEVEL:=1}"
fi

: "${PRODFILES_DANGER_LEVEL:=0}"

if [[ "${TERM}" == "tmux-256color" ]]; then
  TERM="xterm-256color"
fi

for _i in "${plugins[@]}"; do
  if [[ -f "${ZSH_CUSTOM}/plugins/_${_i}/_${_i}.plugin.zsh" ]]; then
    plugins+=("_${_i}")
  fi
done

if [[ "${ENV_DIR:-}" ]] && [[ ! -d "${ENV_DIR}" ]]; then
  echo "Make directory '${ENV_DIR}'"
  mkdir --parents "${ENV_DIR}"
fi

if [[ ! -d "${ZSH}" ]]; then
  ZSH="${ZSH}" KEEP_ZSHRC=yes \
    sh -c "$(
      curl --fail --insecure --location --show-error --silent \
        https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    )"
fi

unset _i

source "${ZSH}/oh-my-zsh.sh"
