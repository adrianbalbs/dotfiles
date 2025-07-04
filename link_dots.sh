#!/bin/sh

# Stow files stored in $XDG_CONFIG_HOME
for dir in *; do
    if [ -d "$dir" ]; then
        if [ ! -d "$HOME/.config/$dir" ]; then
            mkdir "$HOME/.config/$dir"
        fi
        stow --verbose --adopt "$dir" -t "$HOME/.config/$dir/"
    fi
done

# Then stow zsh files
stow --verbose --adopt --target="$HOME" zsh
