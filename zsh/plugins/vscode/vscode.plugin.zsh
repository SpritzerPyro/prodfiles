# shellcheck shell=bash

: "${VSCODE_WORKSPACES:="${HOME}/.config/vscode"}"

alias vc="code ."

function vcw() {
  : "${1:?}"

  local _i

  for _i in "$@"; do
    code "${VSCODE_WORKSPACES}/${_i%.code-workspace}.code-workspace"
  done
}
