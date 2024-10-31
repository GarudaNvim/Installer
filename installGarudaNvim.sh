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

# Step 1.5: Checking for System Dependencies
echo "Step 1.5: Checking for System Dependencies"
echo "------------------------------------------------------------------------------------------------------------------"
echo "Checking for the following dependencies on your system:"
echo "Node, Python, Ripgrep, Lazygit, Htop"
echo "Though these are not strictly needed, it's recommended to have them for a seamless GarudaNvim experience."
echo

dependencies=("node" "python3" "rg" "lazygit" "htop")
installed_dependencies=()
missing_dependencies=()

for dep in "${dependencies[@]}"; do
    if command -v "$dep" >/dev/null 2>&1; then
        installed_dependencies+=("$dep")
    else
        missing_dependencies+=("$dep")
    fi
done

if [ ${#missing_dependencies[@]} -eq 0 ]; then
    echo "INFO: All dependencies are already installed."
else
    echo "INFO: Found installed dependencies: ${installed_dependencies[*]}"
    echo "INFO: Missing dependencies: ${missing_dependencies[*]}"
    for dep in "${missing_dependencies[@]}"; do
        read -p "Would you like to install $dep? (y/n): " install_choice
        if [ "$install_choice" = "y" ]; then
            case "$OS" in
                macOS)
                    if [ "$dep" = "node" ]; then brew install node; fi
                    if [ "$dep" = "python3" ]; then brew install python; fi
                    if [ "$dep" = "rg" ]; then brew install ripgrep; fi
                    if [ "$dep" = "lazygit" ]; then brew install lazygit; fi
                    if [ "$dep" = "htop" ]; then brew install htop; fi
                    ;;
                Ubuntu)
                    sudo apt update
                    if [ "$dep" = "node" ]; then sudo apt install -y nodejs; fi
                    if [ "$dep" = "python3" ]; then sudo apt install -y python3; fi
                    if [ "$dep" = "rg" ]; then sudo apt install -y ripgrep; fi
                    if [ "$dep" = "lazygit" ]; then sudo add-apt-repository ppa:lazygit-team/release && sudo apt install -y lazygit; fi
                    if [ "$dep" = "htop" ]; then sudo apt install -y htop; fi
                    ;;
                Arch)
                    if [ "$dep" = "node" ]; then sudo pacman -Sy nodejs; fi
                    if [ "$dep" = "python3" ]; then sudo pacman -Sy python; fi
                    if [ "$dep" = "rg" ]; then sudo pacman -Sy ripgrep; fi
                    if [ "$dep" = "lazygit" ]; then sudo pacman -Sy lazygit; fi
                    if [ "$dep" = "htop" ]; then sudo pacman -Sy htop; fi
                    ;;
                Fedora)
                    if [ "$dep" = "node" ]; then sudo dnf install -y nodejs; fi
                    if [ "$dep" = "python3" ]; then sudo dnf install -y python3; fi
                    if [ "$dep" = "rg" ]; then sudo dnf install -y ripgrep; fi
                    if [ "$dep" = "lazygit" ]; then sudo dnf install -y lazygit; fi
                    if [ "$dep" = "htop" ]; then sudo dnf install -y htop; fi
                    ;;
                RHEL)
                    if [ "$dep" = "node" ]; then sudo yum install -y nodejs; fi
                    if [ "$dep" = "python3" ]; then sudo yum install -y python3; fi
                    if [ "$dep" = "rg" ]; then sudo yum install -y ripgrep; fi
                    if [ "$dep" = "lazygit" ]; then sudo yum install -y lazygit; fi
                    if [ "$dep" = "htop" ]; then sudo yum install -y htop; fi
                    ;;
            esac
            if command -v "$dep" >/dev/null 2>&1; then
                echo "INFO: $dep has been successfully installed!"
            else
                echo "WARNING: Failed to install $dep. Please install it manually if you want GarudaNvim to function smoothly."
            fi
        else
            echo "Please install $dep manually if you want GarudaNvim to function smoothly."
        fi
    done
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

