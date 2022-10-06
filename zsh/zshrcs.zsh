while IFS= read -r -d '' _i; do
  if [[ -f "${_i}" ]] && [[ "${_i}" != "${HOME}/.zshrc" ]]; then
    source "${_i}"
  fi
done < <(
  find "${HOME}" "${ENV_DIR:-"${HOME}"}" \
    -maxdepth 1 \
    -regextype posix-extended \
    -regex ".*?(\.|\/)zshrc(\.(user|custom|$(whoami)))?$" \
    -type f,l \
    -print0
)

unset _i
