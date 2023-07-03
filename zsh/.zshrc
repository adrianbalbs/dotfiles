# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/adrian/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall
export TERM="xterm-256color"
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export PATH=/home/adrian/scripts:$PATH

eval "$(starship init zsh)"

if [ -f ~/.aliases ]; then
  source ~/.aliases
else
  echo "Missing .aliases files"
fi
fpath+=${ZDOTDIR:-~}/.zsh_functions
source /usr/share/nvm/init-nvm.sh
