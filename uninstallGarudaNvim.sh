#!/usr/bin/env sh
#
# GarudaNvim uninstaller for macOS.

# Welcome message
echo
echo
echo "GarudaNvim Uninstaller!"
echo
echo "=================================================================================================================="
echo

# Step 1: Check if GarudaNvim is installed
echo "Step 1: Checking if GarudaNvim is installed in ~/.config/nvim/lua/garudanvim"
echo "------------------------------------------------------------------------------------------------------------------"
if [ -d ~/.config/nvim/lua/garudanvim ]; then
  echo "INFO: GarudaNvim configuration found."
  echo "Running the uninstallation process."
  echo
else
  echo "ERROR: GarudaNvim is not found in your system."
  echo "       Cannot proceed with the uninstallation process."
  echo
  exit 1
fi

# Step 1.5: Ask for final confirmation before proceeding
read -p "Are you sure you want to uninstall GarudaNvim? (y/n): " confirm
if [ "$confirm" != "y" ]; then
  echo
  echo "Happy Coding with GarudaNvim!"
  echo
  exit 0
fi
echo

# Step 2: Uninstallation Process
echo "Step 2: Removing GarudaNvim and related Neovim configuration directories"
echo "------------------------------------------------------------------------------------------------------------------"
echo "We're sorry to see you leave GarudaNvim!"
echo "Proceeding with the uninstallation..."
echo
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
echo "INFO: GarudaNvim and its related files and folders have been removed."
echo
echo "=================================================================================================================="
echo

# Final message
echo "GarudaNvim has been completely uninstalled."
echo
echo "If you faced any issues with GarudaNvim, we'd gladly take your feedback."
echo "Please visit the official GarudaNvim GitHub page to raise an issue."
echo "Thanks for using GarudaNvim!"
echo
echo
