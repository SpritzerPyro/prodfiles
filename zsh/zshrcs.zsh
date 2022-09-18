for _i in \
  ".zshrc.user" \
  ".zshrc.custom" \
  ".zshrc.$(whoami)" \
; do
  if [[ -f "${HOME}/${_i}" ]]; then
    source "${HOME}/${_i}"
  fi
done

if [[ -d "${ENV_DIR:-}" ]]; then
  for _i in \
    "${ENV_DIR}/zshrc" \
    "${ENV_DIR}/.zshrc" \
    "${ENV_DIR}/zshrc.user" \
    "${ENV_DIR}/.zshrc.user" \
    "${ENV_DIR}/zshrc.custom" \
    "${ENV_DIR}/.zshrc.custom" \
    "${ENV_DIR}/zshrc.$(whoami)" \
    "${ENV_DIR}/.zshrc.$(whoami)" \
  ; do
    if [[ -f "${HOME}/${_i}" ]]; then
      source "${HOME}/${_i}"
    fi
  done
fi

unset _i
