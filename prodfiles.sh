: "${PRODFILES:="$(dirname "$(readlink -f "${0}")")"}"

: "${ZSH:="${PRODFILES}/.oh-my-zsh"}"
: "${ZSH_CUSTOM:="${PRODFILES}/zsh"}"
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

if [[ ! -d "${ZSH}" ]]; then
  ZSH="${ZSH}" KEEP_ZSHRC=yes \
    sh -c "$(
      curl --fail --insecure --location --show-error --silent \
        https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    )"
fi

source "${ZSH}/oh-my-zsh.sh"
