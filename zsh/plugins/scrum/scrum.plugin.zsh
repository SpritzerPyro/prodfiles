function scb() {
  local -r issue=$(sgi)
  local name
  name=$(echo "$*" | sed --regexp-extended 's/(\.|\s+)/-/g')

  if [[ "${issue:-}" ]]; then
    name="${issue}-${name}"
  fi

  git checkout -b "${name}"
}

function sgi() {
  local -r number=$(
    head --lines=1 "${SCRUM_PLUGIN_DIR}/.number" 2>/dev/null || echo ""
  )

  if [[ "${number}" ]]; then
    echo "${SCRUM_ISSUE_PREFIX}-${number}"
  fi
}

function ssi() {
  echo "${1:-}" > "${SCRUM_PLUGIN_DIR}/.number"

  local file

  file="$(git config commit.template || echo "")"
  file="${file/#\~/"${HOME}"}"

  if [[ ! "${file}" ]]; then
    echo "No valid commit template set in the git config"
    return
  fi

  local -r original=$(cat "${file}" 2>/dev/null || echo "")
  local -r issue=$(sgi)

  if [[ "${issue}" ]]; then
    echo "Set scrum issue to '${issue}'"
    echo "Add '[${issue}]' to '${file}'"
  else
    echo "Clear scrum issue"
    echo "Remove issue from '${file}'"
  fi

  local -r content="$(
    echo
    {
      echo;
      echo "${original}" \
        | sed --quiet --regexp-extended --expression \
          "/^\[${SCRUM_ISSUE_PREFIX}-.+?\]$/!p";
      echo;
    } \
      | cat --squeeze-blank

    if [[ "${issue:-}" ]]; then
      echo "[${issue}]"
    fi
  )"

  echo "${content}" > "${file}"
}

: "${SCRUM_ISSUE_PREFIX:=JIRA}"
: "${SCRUM_PLUGIN_DIR:="${0:A:h}"}"
