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

alias ls="ls --color=auto"
alias sd="cd ~ && cd \$(find * -type d | fzf)"

export TERM="xterm-256color"
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export PATH=/home/adrian/scripts:$PATH

eval "$(starship init zsh)"

# Your zID (change this)
_SSHFS_ZID=z5397730
# Your desired mountpoint for your CSE home directory
_SSHFS_CSE_MOUNT="$HOME/cse"

alias csemnt="sshfs -o idmap=user -C ${_SSHFS_ZID}@login.cse.unsw.edu.au: ${_SSHFS_CSE_MOUNT}"
alias cseumount="umount ${_SSHFS_CSE_MOUNT}"

function cse() {
    # determine where we are relative to the mountpoint (thanks @ralismark)
    local rel=${PWD##${_SSHFS_CSE_MOUNT}}

    if [ -z "$1" ]; then
        # if we don't have arguments, we give the user a shell on the remote cse machine.
        if [ "$PWD" = "$rel" ]; then
            # in the case that we're not in our mountpoint, provide a shell in their home directory.
            ssh "${_SSHFS_ZID}@login.cse.unsw.edu.au"
        else
            # if within the mountpoint, cd to the equivalent dir on the remote before providing a shell (thanks @ralismark)
            ssh "${_SSHFS_ZID}@login.cse.unsw.edu.au" -t "cd $(printf "%q" "./$rel"); exec \$SHELL -l"
        fi
    else
        # if we have arguments, we have a command to execute.
        if [ "$PWD" = "$rel" ]; then
            # in the case that we're not in our mountpoint, we'll execute in the home directory.
            ssh -qt "${_SSHFS_ZID}@login.cse.unsw.edu.au" "$@"
        else
            # if within the mountpoint, cd to the equivalent dir on the remote before executing (thanks @ralismark)
            ssh "${_SSHFS_ZID}@login.cse.unsw.edu.au" -qt "cd $(printf "%q" "./$rel") && $(printf "%q " "$@")"
        fi
    fi
}

fpath+=${ZDOTDIR:-~}/.zsh_functions
source /usr/share/nvm/init-nvm.sh
