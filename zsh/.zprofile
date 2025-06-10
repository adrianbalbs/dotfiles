# Setting PATH for Python 3.12
# The original version is saved in .zprofile.pysave

export FLYCTL_INSTALL="/home/adrianb/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
