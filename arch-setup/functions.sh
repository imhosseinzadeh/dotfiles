#!/bin/bash

# Function to log messages
log() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" | tee -a "$LOG_FILE"
}

# Function to check internet connection
check_internet_connection() {
    log "Checking internet connection..."

    if ! ping -c 1 archlinux.org &>/dev/null && ! curl -s https://archlinux.org &>/dev/null; then
        log "No internet connection detected. Please check your network and try again."
        return 1
    fi

    log "Internet connection is active."
    return 0
}

# Function to check if a package is installed
is_package_installed() {
    pacman -Q "$1" &>/dev/null
}

# Function to update the system
update_system() {
    log "Updating system..."
    if ! sudo pacman -Syu --noconfirm; then
        log "System update failed. Exiting..."
        exit 1
    fi
}

# Function to install packages
install_packages() {
    log "Installing packages..."
    if ! sudo pacman -S --noconfirm --needed "${PACKAGES[@]}"; then
        log "Package installation failed. Exiting..."
        exit 1
    fi
}

# Function to enable Bash completion
enable_bash_completion() {
    log "Enabling Bash completion..."
    BASHRC_FILE="$HOME/.bashrc"
    if ! grep -q "source /usr/share/bash-completion/bash_completion" "$BASHRC_FILE"; then
        echo "source /usr/share/bash-completion/bash_completion" >> "$BASHRC_FILE"
    fi
    log "Bash completion enabled. Changes will take effect after restarting the terminal."
}

# Function to set Neovim as the default editor
set_default_editor() {
    log "Setting Neovim as the default editor..."

    # Add to ~/.bashrc (for interactive shells)
    BASHRC_FILE="$HOME/.bashrc"
    if ! grep -q "export EDITOR=nvim" "$BASHRC_FILE"; then
        echo "export EDITOR=nvim" >> "$BASHRC_FILE"
    fi
    if ! grep -q "export VISUAL=nvim" "$BASHRC_FILE"; then
        echo "export VISUAL=nvim" >> "$BASHRC_FILE"
    fi

    log "Neovim set as the default editor. Changes will take effect after restarting the terminal."
}
