#!/usr/bin/env sh
#
# GarudaNvim installer for macOS.

# Welcome message
echo
echo
echo "Welcome to GarudaNvim!"
echo "This installer supports Operating Systems like MacOS, Arch, Fedora, CentOS, RHEL, Ubuntu and Debian"
echo "And all their distributions!"
echo
echo "=================================================================================================================="
echo

# Step 0: Detect OS
echo "Step 0: Detecting Operating System"
echo "------------------------------------------------------------------------------------------------------------------"
OS=""
if [ "$(uname)" = "Darwin" ]; then
  OS="macOS"
elif [ -f /etc/os-release ]; then
  . /etc/os-release
  case "$ID" in
    ubuntu|debian)
      OS="Ubuntu"
      ;;
    arch)
      OS="Arch"
      ;;
    fedora)
      OS="Fedora"
      ;;
    centos|rhel)
      OS="RHEL"
      ;;
    *)
      OS="Unsupported"
      ;;
  esac
else
  OS="Unsupported"
fi

if [ "$OS" = "Unsupported" ]; then
  echo "ERROR: Your operating system is not supported by this installer."
  echo "Supported OS: macOS, Arch, Ubuntu, Debian, Fedora, CentOS, RHEL. And their distributions."
  echo
  echo
  exit 1
fi
echo "INFO: Detected OS - $OS"
# Ensure the ~/.config/ directory exists
if [ ! -d ~/.config ]; then
  echo "INFO: ~/.config/ directory not found. Creating it..."
  mkdir -p ~/.config
fi
echo "INFO: System checks passed! Continuing with installation."
echo
echo

# Step 1: Check if Neovim is installed
echo "Step 1: Checking if Neovim is already installed"
echo "------------------------------------------------------------------------------------------------------------------"
if command -v nvim >/dev/null 2>&1; then
  echo "INFO: Neovim is already installed on your system!"
else
  echo "INFO: Neovim is not installed. Installing Neovim for $OS..."
  
  case "$OS" in
    macOS)
      if ! command -v brew >/dev/null 2>&1; then
        echo "ERROR: Homebrew is not installed. Please install Homebrew to proceed."
        echo "Visit https://brew.sh/ for instructions."
        echo
        echo
        exit 1
      fi
      brew install neovim
      ;;
    Ubuntu)
      sudo apt update
      sudo apt install -y neovim
      ;;
    Arch)
      sudo pacman -Sy neovim
      ;;
    Fedora)
      sudo dnf install -y neovim
      ;;
    RHEL)
      sudo yum install -y neovim
      ;;
  esac

  if command -v nvim >/dev/null 2>&1; then
    echo "INFO: Neovim has been successfully installed!"
  else
    echo "ERROR: Failed to install Neovim. Please try installing it manually."
    echo
    echo
    exit 1
  fi
fi
echo
echo

# Step 2: Check for existing Neovim configuration
echo "Step 2: Checking for existing Neovim configuration in ~/.config/nvim"
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
      echo
      echo "INFO: Please manually backup your configuration and try installing GarudaNvim again."
      echo
      echo
      exit 1
    fi
  fi
else
  echo "INFO: No existing Neovim configuration found. Continuing with installation."
fi
echo
echo

# Step 3: Cloning GarudaNvim repository
echo "Step 3: Installing GarudaNvim to ~/.config/nvim"
echo "------------------------------------------------------------------------------------------------------------------"
# Clone the repository
git clone https://github.com/garudanvim/GarudaNvim.git ~/.config/nvim
cd ~/.config/nvim || exit 1
echo "Cloned the Repository."
# Fetch the latest release tag
latest_tag=$(git describe --tags $(git rev-list --tags --max-count=1))
# Reset to the commit of the latest release
git reset --hard "$latest_tag"
echo "Set GarudaNvim to the latest release"
echo
echo "=================================================================================================================="
echo


# Success message and opening GarudaNvim
echo "SUCCESS: GarudaNvim has been correctly installed!"
echo "Type \"nvim\" in your terminal to start GarudaNvim"
echo "Happy Coding!"
echo
echo

