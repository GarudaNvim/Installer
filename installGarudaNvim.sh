#!/usr/bin/env sh
#
# GarudaNvim installer for macOS.

# Welcome message
echo
echo
echo "Welcome to GarudaNvim!"
echo "This installer is designed for macOS."
echo
echo "=================================================================================================================="
echo

# Step 1: Check for existing Neovim configuration
echo "Step 1: Checking for existing Neovim configuration in ~/.config/nvim"
echo "------------------------------------------------------------------------------------------------------------------"
if [ -d ~/.config/nvim ]; then
  echo "WARNING: The directory ~/.config/nvim already exists."
  echo "       You have two options:"
  echo "       1. Delete your current Neovim configuration and install GarudaNvim."
  echo "       2. Backup your current Neovim configuration before installing GarudaNvim."
  echo
  read -p "Would you like to delete the existing configuration? (y/n): " delete_choice
  if [ "$delete_choice" = "y" ]; then
    echo "INFO: Deleting existing Neovim configuration..."
    # Deleting current configuration
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.cache/nvim
    echo "INFO: Existing configuration deleted."
  else
    echo
    echo "Step 1.5: Backup Options"
    echo "------------------------------------------------------------------------------------------------------------------"
    echo "You can either automatically backup your current Neovim configuration or manually do it."
    read -p "Would you like to automatically backup and proceed with the installation? (y/n): " backup_choice
    if [ "$backup_choice" = "y" ]; then
      echo "INFO: Backing up current Neovim configuration..."
      # Automatically backup the current configuration
      mv ~/.config/nvim{,.bak}
      # Optional but recommended backups
      mv ~/.local/share/nvim{,.bak}
      mv ~/.local/state/nvim{,.bak}
      mv ~/.cache/nvim{,.bak}
      echo "INFO: Backup complete!"
    else
      echo "INFO: Please manually backup your configuration and try installing GarudaNvim again."
      echo
      exit 1
    fi
  fi
else
  echo "INFO: No existing Neovim configuration found."
fi
echo
echo

# Step 2: Cloning GarudaNvim repository
echo "Step 2: Installing GarudaNvim to ~/.config/nvim"
echo "------------------------------------------------------------------------------------------------------------------"
git clone https://github.com/garudanvim/GarudaNvim.git ~/.config/nvim
cd ~/.config/nvim || exit 1
echo
echo "=================================================================================================================="
echo

# Success message
echo "SUCCESS: GarudaNvim has been correctly installed!"
echo "Happy Coding!"
echo
echo "=================================================================================================================="
echo

# Opening GarudaNvim
echo "PRESS ENTER TO OPEN IT"
read -r
nvim
