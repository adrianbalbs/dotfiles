#!/bin/bash

# Installs any developer dependencies on Arch via pacman

# List of packages to install
packages=(
    git
    neovim
    btop
    curl
    wget
    zoxide
    wezterm
    starship
    tree-sitter
    stow
    ripgrep
    fd
    obsidian
    fzf
    eza
    bat
    go
    rustup
    python
    jdk-openjdk
    clang
    gcc
)

echo "Installing packages"

for pkg in "${packages[@]}"; do
    if pacman -Qi "$pkg" &>/dev/null; then
        echo "$pkg is already installed"
    else
        echo "Installing $pkg"
        sudo pacman -S --noconfirm "$pkg"
    fi
done

# Node Installation Manager of Choice
echo "Installing Volta"
if [[ ! -d $HOME/.volta ]]; then
    curl https://get.volta.sh | bash
else
    echo "Volta already installed"
fi

echo "Finished installing packages"
