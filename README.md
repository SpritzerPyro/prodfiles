# prodfiles

Dotfiles, designed to handle production systems.

## Install

Using the zsh `prodfiles` requires `zsh` and `oh-my-zsh`. Follow the instruction in [the `oh-my-zsh` repository](https://github.com/ohmyzsh/ohmyzsh#getting-started) to install both.

Afterward, clone the `prodfiles` anywhere you want and source the `prodfiles.sh` script **at the end** of your `.zshrc`.

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
source "${HOME}/.prodfiles/prodfiles.sh"

# EOF
```

## Danger zone

The prodfiles originally are created for developers handling development and production systems, especially using ssh. The original purpose was to help you identify whether you are on your development, or, on a production system. This information follows a traffic light system. If you are on your machine, the environment is considered safe. If you are connected via ssh, you at least should be cautionary. And then there is the danger zone. Per default, the danger zone has been entered when connecting via ssh immediately. So there is only green and red per default. But you can adapt the danger zone by overwriting the `prodfiles_danger_zone` function in your `.zshrc` file. The function must return true or false, so 0 or any other number.

If you want for example only enter the danger zone if the `NODE_ENV` is set to production you can define this function in your `.zshrc`.

```bash
function prodfiles_danger_zone() {
  [[ "${NODE_ENV}" == "production" ]]
}
```

Now, if you are connected via SSH the traffic light only shows yellow. But if your `NODE_ENV` is set to production (whether connected via ssh or not), you are in the danger zone.

There are two variables set automatically you can use. The `${PRODFILES_DANGER_ZONE}` variable is set to "1" if you are in the danger zone, or else to "0". To access the traffic light, use the "${PRODFILES_DANGER_LEVEL}" variable. From green to red, the variable is set to "0", "1", and "2".

```bash
(( PRODFILES_DANGER_ZONE )) && echo "You absolutely are in the danger zone!"
(( ! PRODFILES_DANGER_LEVEL )) && echo "Welcome to your happy place."
(( PRODFILES_DANGER_LEVEL == 1 )) && echo "Are you sure about this?"
```
