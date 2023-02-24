_prodfiles_start_timestamp="$(date +%s%3N)"

: "${PRODFILES:="$(dirname "$(readlink -f "${0}")")"}"
: "${ANTIDOTE_DIR:="${PRODFILES}/.antidote"}"

: "${ZDOTDIR:="${HOME}"}"
: "${ZSH_CACHE_DIR:="${HOME}/.cache/zsh"}"

: "${DISABLE_UNTRACKED_FILES_DIRTY:="true"}"
: "${EDITOR:="vim"}"
: "${HIST_STAMPS:="yyyy-mm-dd"}"
: "${TERM:="xterm-256color"}"

export EDITOR ZDOTDIR ZSH

for _prodfiles_i in "${ZDOTDIR}" "${ZSH_CACHE_DIR}"; do
  [[ ! -d "${_prodfiles_i}" ]] && mkdir -p "${_prodfiles_i}"
done

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

if [[ "${ENV_DIR:-}" ]] && [[ ! -d "${ENV_DIR}" ]]; then
  echo "Make directory '${ENV_DIR}'"
  mkdir --parents "${ENV_DIR}"
fi

if [[ ! -d "${ANTIDOTE_DIR}" ]]; then
  git clone https://github.com/mattmc3/antidote.git "${ANTIDOTE_DIR}"
fi

: "${ZSH_PLUGINS:="${ZDOTDIR}/.zsh_plugins.txt"}"

[[ -f "${ZSH_PLUGINS}" ]] || touch "${ZSH_PLUGINS}"

fpath+=("${ANTIDOTE_DIR}")
autoload -Uz "${fpath[-1]}/antidote"

if [[ ! "${ZSH_PLUGINS:r}.zsh" -nt "${ZSH_PLUGINS}" ]]; then
  (antidote bundle < "${ZSH_PLUGINS}" >| "${ZSH_PLUGINS:r}.zsh")
fi

source "${ZSH_PLUGINS:r}.zsh"
