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
  echo "${1#"${SCRUM_ISSUE_PREFIX}-"}" > "${SCRUM_PLUGIN_DIR}/.number"

  local -r issue=$(sgi)

  if [[ "${issue}" ]]; then
    echo "Scrum Plugin: Set issue to '${issue}'"
  else
    echo "Scrum Plugin: Clear issue"
  fi

  if \
    [[ "${SCRUM_PLUGIN_COMMIT_TEMPLATE:-1}" == "0" ]] || \
    [[ "${SCRUM_PLUGIN_COMMIT_TEMPLATE:-1}" == "false" ]] \
  ; then
    return
  fi

  local file

  file="$(git config commit.template || echo "")"
  file="${file/#\~/"${HOME}"}"

  if [[ ! "${file}" ]]; then
    echo "Scrum Plugin: No valid commit template set in the git config"
    echo "Scrum Plugin: Add commit.template to the configs (adapt the path if you like)"
    echo "Scrum Plugin: Run 'git config --global commit.template \"~/.gitmessage\"'"

    return
  fi

  mkdir -p "${file:A:h}"

  if [[ "${issue}" ]]; then
    echo "Scrum Plugin: Add '[${issue}]' to '${file}'"
  else
    echo "Scrum Plugin: Remove issue from '${file}'"
  fi

  local -r original=$(cat "${file}" 2>/dev/null || echo "")
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

if \
  [[ "${SCRUM_PLUGIN_COMMIT_TEMPLATE:-1}" != "0" ]] && \
  [[ "${SCRUM_PLUGIN_COMMIT_TEMPLATE:-1}" != "false" ]] \
; then
  _scrum_plugin_file="$(git config commit.template || echo "")"
  _scrum_plugin_file="${_scrum_plugin_file/#\~/"${HOME}"}"

  if [[ "${_scrum_plugin_file}" ]] && [[ ! -f "${_scrum_plugin_file}" ]]; then
    echo "Scrum Plugin: Create not existing '${_scrum_plugin_file}'"
    mkdir -p "${_scrum_plugin_file:A:h}"
    touch "${_scrum_plugin_file}"
  fi

  unset _scrum_plugin_file
fi

: "${SCRUM_ISSUE_PREFIX:=JIRA}"
: "${SCRUM_PLUGIN_DIR:="${0:A:h}"}"
