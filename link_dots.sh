# Stow files stored in $XDG_CONFIG_HOME
for dir in *
do
    if [ -d "$dir" ]; then
        if [ ! -d "$HOME/.test/$dir" ]; then
            mkdir "$HOME/.test/$dir"
        fi
        stow --verbose "$dir" -t "$HOME/.test/$dir/"
    fi
done

# Then stow zsh files
stow --verbose zsh
