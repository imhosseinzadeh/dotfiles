#!/bin/bash

# List of packages to install
PACKAGES=(

    ### Core System Utilities ###
    pacman-contrib
    bash-completion
    man
    tree
    jq
    rtkit

    ### Clipboard & File Access ###
    wl-clipboard
    xdg-desktop-portal-wlr
    gvfs
    gvfs-mtp
    mtpfs

    ### Filesystem Support ###
    dosfstools
    exfatprogs
    unrar
    xarchiver

    ### Fonts ###
    noto-fonts
    noto-fonts-emoji
    cantarell-fonts
    ttf-dejavu
    ttf-fira-code
    ttf-liberation
    ttf-font-awesome
    ttf-nerd-fonts-symbols

    ### Terminal & CLI Tools ###
    vim
    nvim
    python-pynvim

    ### Development Tools ###
    git
    gcc
    go
    openjdk21-src
    npm
    luarocks

    ### Containers & Databases ###
    docker
    docker-compose
    postgresql

    ### Sway WM Utilities ###
    wmenu
    nwg-drawer

    ### GUI Applications ###
    zathura
    zathura-pdf-poppler
    # File Management
    nautilus
    # Image Viewing
    imv
    eog
    # Multimedia
    mpv
    vlc
    cmus
    # Productivity
    keepassxc
    # Internet
    firefox
    telegram-desktop
    gnome-text-editor

    swappy

    ### System Services ###
    polkit-gnome

    ### TeX/Document Processing ###
    texlive-basic
    texlive-xetex
    texlive-langarabic
    texlive-langenglish
)

# Log file
LOG_FILE="logs/arch_install.log"
