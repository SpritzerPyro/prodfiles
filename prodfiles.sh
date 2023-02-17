: "${PRODFILES:="$(dirname "$(readlink -f "${0}")")"}"

: "${ZDOTDIR:="${HOME}"}"
: "${ZSH:="${PRODFILES}/.oh-my-zsh"}"
: "${ZSH_CUSTOM:="${PRODFILES}/zsh"}"
: "${ZSH_THEME:="cautionary"}"

: "${DISABLE_UNTRACKED_FILES_DIRTY:="true"}"
: "${EDITOR:="vim"}"
: "${HIST_STAMPS:="yyyy-mm-dd"}"
: "${TERM:="xterm-256color"}"

export EDITOR ZDOTDIR ZSH

if ! typeset -f -F danger_zone &>/dev/null; then
  function danger_zone() {
    return 1
  }
fi

if ! typeset -f -F risk_zone &>/dev/null; then
  function risk_zone() {
    [[ "${SSH_CONNECTION:-}" ]]
  }
fi

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
