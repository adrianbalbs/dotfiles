alias ls='ls -G'
export CLICOLOR=1
export LSCOLORS=gxFxCxDxBxegedabagaced

if [ -f ~/.aliases ]; then
  source ~/.aliases
else
  echo "Missing .aliases file"
fi

bindkey '^[ ' autosuggest-accept

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Use gnu coreutils instead of mac coreutils
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="$PATH:/opt/gradle/gradle-7.2/bin"

[ -f "/Users/adrian/.ghcup/env" ] && source "/Users/adrian/.ghcup/env" # ghcup-envexport PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
