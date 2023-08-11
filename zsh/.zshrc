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


export TERM="xterm-256color"
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export PATH=/home/adrian/scripts:$PATH

# Keybindings
bindkey '^H' backward-kill-word
bindkey '^[^?' backward-delete-word
bindkey '^[[3;5~' kill-word
bindkey '^[[3;3~' delete-word
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^ ' autosuggest-accept
bindkey '^E' end-of-line
bindkey '^A' beginning-of-line
eval "$(starship init zsh)"

if [ -f ~/.aliases ]; then
  source ~/.aliases
else
  echo "Missing .aliases files"
fi


fpath+=${ZDOTDIR:-~}/.zsh_functions
source /usr/share/nvm/init-nvm.sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Created by `pipx` on 2023-08-10 09:20:57
export PATH="$PATH:/home/adrian/.local/bin"
