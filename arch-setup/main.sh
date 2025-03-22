#!/bin/bash

# Ensure logs directory exists
mkdir -p logs

 # Source configuration and functions
 for file in config.sh functions.sh utils/network.sh utils/users.sh; do
     if [[ ! -f "$file" ]]; then
         echo "Error: Missing required file: $file" | tee -a "$LOG_FILE"
         exit 1
     fi
     source "$file"
 done

# Redirect all output to the log file
exec > >(tee -a "$LOG_FILE") 2>&1

log "Starting Arch Linux setup script..."

# Check internet connection
if ! check_internet_connection; then
    exit 1
fi

update_system

install_packages

enable_bash_completion

if is_package_installed neovim; then
    set_default_editor
else
    log "Neovim is not installed. Skipping default editor setup."
fi

# Enable and start Docker if installed
if is_package_installed docker; then
    log "Enabling and starting Docker service..."
    sudo systemctl enable --now docker.socket
    if ! groups "$USER" | grep -q '\bdocker\b'; then
        sudo usermod -aG docker "$USER"
    fi
    log "Docker service enabled. You may need to log out and back in for group changes to take effect."
fi

log "Arch Linux setup completed!"
log "Please log out and back in for the following changes to take effect:"
log "  - Docker group membership"
log "  - Default editor (Neovim)"
