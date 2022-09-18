if [[ ! -d "${0:A:h}/zsh-autosuggestions" ]]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    "${0:A:h}/zsh-autosuggestions"
fi

source "${0:A:h}/zsh-autosuggestions/zsh-autosuggestions.zsh"
