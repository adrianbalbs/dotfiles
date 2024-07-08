# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Keybinds
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza $realpath'

autoload -U compinit && compinit
zinit cdreplay -q

alias ls='eza --icons --git'
export CLICOLOR=1
export LSCOLORS=gxFxCxDxBxegedabagaced

[ -f ~/.aliases ] && source ~/.aliases

# Exports and PATH 
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Use gnu coreutils instead of mac coreutils
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

export PATH="$PATH:/opt/gradle/gradle-7.2/bin"

[ -f "/Users/adrian/.ghcup/env" ] && source "/Users/adrian/.ghcup/env" # ghcup-envexport PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pnpm
export PNPM_HOME="/Users/adrian/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
