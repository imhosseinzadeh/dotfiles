#!/bin/bash

# List of packages to install
PACKAGES=(
    # System Essentials and CLI Utilities
    pacman-contrib
    bash-completion
    man
    tree
    wl-clipboard
    xdg-desktop-portal-wlr

    # Editors and Terminal Emulators
    vim
    neovim
    alacritty

    # Miscellaneous CLI Tools
    wmenu
    rtkit

    # File and Media Management
    unrar
    imv
    thunar
    thunar-volman
    thunar-archive-plugin
    gvfs
    gvfs-mtp
    mtpfs
    xarchiver
    dosfstools
    exfatprogs

    # Fonts
    noto-fonts
    noto-fonts-emoji
    ttf-nerd-fonts-symbols

    # Development Tools
    git
    gcc
    go
    openjdk21-src
    npm
    luarocks

    # Containerization and Databases
    docker
    docker-compose
    postgresql

    # Web and Communication
    firefox
    telegram-desktop
    keepassxc

    # Multimedia Players and Audio
    mpv
    vlc
    cmus

    # TeX / Document Processing
    texlive-basic
    texlive-xetex
    texlive-langarabic
    texlive-langenglish
)

# Log file
LOG_FILE="logs/arch_install.log"
