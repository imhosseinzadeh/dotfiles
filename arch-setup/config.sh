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

    # Sway
    wmenu
    nwg-drawer

    # Editors and Terminal Emulators
    vim
    neovim
    alacritty

    # Miscellaneous CLI Tools
    rtkit

    # File and Media Management
    unrar
    imv
    gvfs
    gvfs-mtp
    mtpfs
    xarchiver
    dosfstools
    exfatprogs

    # Gnome
    gnome-polkit
    nautilus
    eog

    # Fonts
    noto-fonts
    noto-fonts-emoji
    cantarell-fonts
    ttf-dejavu
    ttf-fira-code
    ttf-liberation
    ttf-font-awesome
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
