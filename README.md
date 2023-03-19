# prodfiles

Dotfiles, designed to handle production systems.

## Install

### zsh prodfiles

Clone the `prodfiles` anywhere you want and source the `prodfiles.zsh` script **at the end** of your `.zshrc`.

```bash
# You can clone the repository anywhere you want, e.g. into your home directory
git clone https://github.com/SpritzerPyro/prodfiles.git "${HOME}/.prodfiles"
```

```bash
# .zshrc (probably ~/.zshrc)
# ...

##
# Source the prodfiles
# Adapt the path if you cloned the repository somewhere else
#
source "${HOME}/.prodfiles/prodfiles.zsh"

# EOF
```
