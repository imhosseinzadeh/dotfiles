#!/bin/bash

# Function to display help
show_help() {
    echo "Usage: $0 <postgres_password>"
    echo "Automates package installation and PostgreSQL setup on Arch Linux."
    echo ""
    echo "Arguments:"
    echo "  <postgres_password>  Password to set for the PostgreSQL user."
    echo ""
    echo "Options:"
    echo "  -h, --help          Display this help message and exit."
    exit 0
}

# Check if help flag is provided
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
fi

# Check if the password parameter is provided
if [[ -z "$1" ]]; then
    echo "Error: Missing required argument <postgres_password>."
    show_help
fi

POSTGRES_PASSWORD="$1"

# Log file
LOG_FILE="arch_install.log"
exec > >(tee -a "$LOG_FILE") 2>&1

# Check internet connection
echo "Checking internet connection..."
if ! ping -c 1 archlinux.org &>/dev/null; then
    echo "No internet connection detected. Please check your network and try again."
    exit 1
fi

echo "Internet connection is active. Proceeding with installation."

# Update system
echo "Updating system..."
if ! sudo pacman -Syu --noconfirm; then
    echo "System update failed. Exiting..."
    exit 1
fi

# List of packages to install
PACKAGES=(
    bash-completion
    wl-clipboard
    vim
    neovim
    alacritty
    ttf-nerd-fonts-symbols
    git
    gcc
    go
    openjdk21-src
    docker
    libnet
    postgresql
    postgresql-libs
    intellij-idea-community-edition
    firefox
    keepassxc
    vlc
    cmus
    telegram-desktop
    texlive-basic
    texlive-xetex
    texlive-langarabic
    texlive-langenglish
)

# Install packages
echo "Installing packages..."
if ! sudo pacman -S --noconfirm --needed "${PACKAGES[@]}"; then
    echo "Package installation failed. Exiting..."
    exit 1
fi

# Enable Bash completion
echo "Enabling Bash completion..."
BASHRC_FILE="$HOME/.bashrc"
if ! grep -q "source /usr/share/bash-completion/bash_completion" "$BASHRC_FILE"; then
    echo "source /usr/share/bash-completion/bash_completion" >> "$BASHRC_FILE"
fi

echo "Bash completion enabled. Changes will take effect after restarting the terminal."

# Set default terminal emulator and editor in ~/.profile
echo "Setting up default terminal emulator and editor in ~/.profile..."
PROFILE_FILE="$HOME/.profile"

if ! grep -q "export TERMINAL=alacritty" "$PROFILE_FILE"; then
    echo "export TERMINAL=alacritty" >> "$PROFILE_FILE"
fi

if ! grep -q "export EDITOR=nvim" "$PROFILE_FILE"; then
    echo "export EDITOR=nvim" >> "$PROFILE_FILE"
fi

if ! grep -q "export VISUAL=nvim" "$PROFILE_FILE"; then
    echo "export VISUAL=nvim" >> "$PROFILE_FILE"
fi

echo "Defaults set in ~/.profile. Changes will take effect after logout or reboot."

# Enable and start Docker if installed
if pacman -Q docker &>/dev/null; then
    echo "Enabling and starting Docker service..."
    sudo systemctl enable --now docker.socket
    sudo usermod -aG docker "$USER"
    echo "Docker service enabled. You may need to log out and back in for group changes to take effect."
fi

# Initialize and start PostgreSQL
if pacman -Q postgresql &>/dev/null; then
    if ! systemctl is-active --quiet postgresql; then
        echo "Initializing PostgreSQL database..."
        sudo -iu postgres initdb -D /var/lib/postgres/data
        sudo systemctl enable --now postgresql

        # Create a PostgreSQL user with the current system username and provided password
        CURRENT_USER=$(whoami)
        sudo -iu postgres psql -c "CREATE USER $CURRENT_USER WITH CREATEDB LOGIN PASSWORD '$POSTGRES_PASSWORD';"
        sudo -iu postgres psql -c "CREATE DATABASE lab OWNER $CURRENT_USER;"
        echo "PostgreSQL setup complete!"
    else
        echo "PostgreSQL is already running. Skipping initialization."
    fi
fi

echo "Installation complete!"
