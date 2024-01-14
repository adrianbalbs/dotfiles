alias ls='ls --color'
export CLICOLOR=1
export LSCOLORS=gxFxCxDxBxegedabagaced

[ -f ~/.aliases ] && source ~/.aliases


export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Use gnu coreutils instead of mac coreutils
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"


# export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="$PATH:/opt/gradle/gradle-7.2/bin"

[ -f "/Users/adrian/.ghcup/env" ] && source "/Users/adrian/.ghcup/env" # ghcup-envexport PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
