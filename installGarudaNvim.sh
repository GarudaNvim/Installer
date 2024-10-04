#!/usr/bin/env sh
#
# GarudaNvim installer for macOS.

# Welcome message
echo
echo "Welcome to GarudaNvim!"
echo "This installer is designed for macOS."
echo
echo "================================================================================="
echo

# Step 1: Check for existing Neovim configuration
echo "Step 1: Checking for existing Neovim configuration in ~/.config/nvim"
echo "---------------------------------------------------------------------------------"
if [ -d ~/.config/nvim ]; then
  echo "ERROR: The directory ~/.config/nvim already exists."
  echo "       Please move it to a different location and try again."
  echo
  exit 1
fi
echo "INFO: No existing Neovim configuration found."
echo
echo

# Step 2: Cloning GarudaNvim repository
echo "Step 2: Installing GarudaNvim to ~/.config/nvim"
echo "---------------------------------------------------------------------------------"
git clone https://github.com/garudanvim/GarudaNvim.git ~/.config/nvim
cd ~/.config/nvim || exit 1
echo
echo

# Step 3: Removing the .git folder
echo "Step 3: Cleaning up"
echo "---------------------------------------------------------------------------------"
rm -rf .git
echo ".git folder removed."
echo
echo "================================================================================="
echo

# Success message
echo "SUCCESS: GarudaNvim has been correctly installed!"
echo "Happy Coding!"
echo
echo "================================================================================="
echo

# Opening GarudaNvim
echo "PRESS ENTER TO OPEN IT"
read -r
nvim

