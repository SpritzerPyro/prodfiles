for _i in \
  ".zshrc.$(whoami)" \
  ".zshrc.custom" \
  ".zshrc.user" \
  ".env.d/.zshrc.$(whoami)" \
  ".env.d/.zshrc.custom" \
  ".env.d/.zshrc.user" \
  ".env.d/.zshrc" \
  ".env.d/zshrc.$(whoami)" \
  ".env.d/zshrc.custom" \
  ".env.d/zshrc.user" \
  ".env.d/zshrc" \
; do
  if [[ -f "${HOME}/${_i}" ]]; then
    source "${HOME}/${_i}"
  fi
done
