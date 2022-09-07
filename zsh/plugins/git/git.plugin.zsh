if is_plugin "${ZSH}" git; then
  source "${ZSH}/plugins/git/git.plugin.zsh"
fi

alias gh="git log --pretty=format:\"%Cred%h%Creset %Cgreen%ad%Creset | %s %b%C(yellow)%d%Creset %C(bold blue)[%an]%Creset\" --graph --date=short"

alias gpn='git push --no-verify'
alias gpnd='git push --no-verify --dry-run'
alias gpnf!='git push --no-verify --force'
alias gpnf='git push --no-verify --force-with-lease'
