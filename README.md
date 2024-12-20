# Installer

Welcome to the **GarudaNvim Installer** repository! This repository contains scripts to easily install and uninstall **GarudaNvim**, a powerful and efficient Neovim configuration, tailored for macOS.

---

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Features](#features)
- [Uninstallation](#uninstallation)
- [Feedback and Issues](#feedback-and-issues)

---

## Introduction

**GarudaNvim** is a custom configuration for Neovim designed to boost productivity, tailored specifically for macOS users. With easy-to-use installer and uninstaller scripts, you can manage your GarudaNvim setup seamlessly.

---

## Installation

### Steps to Install GarudaNvim

To install GarudaNvim on your macOS system, simply follow these steps:

1. Run the following command in your terminal for the latest release of Installer:
   ```sh
   LATEST=$(curl -s https://api.github.com/repos/GarudaNvim/Installer/releases/latest | grep '"tag_name"' | cut -d '"' -f 4)
   wget -q https://raw.githubusercontent.com/GarudaNvim/Installer/$LATEST/installGarudaNvim.sh
   chmod +x installGarudaNvim.sh && { ./installGarudaNvim.sh } || { echo }
   rm -f installGarudaNvim.sh
   ```

2. Follow the on-screen prompts:
   - The installer script automatically detects the **operating system** (macOS, Linux) and checks if your system is compatible with GarudaNvim.
   
   - The script checks if **Neovim is pre-installed**. If Neovim is not found, it will automatically install Neovim based on your operating system before proceeding with the GarudaNvim installation.

   - If an existing Neovim configuration is found, you'll be given two options:
     - **Delete** your current Neovim configuration and proceed with the GarudaNvim installation.
     - **Backup (Automatic/Manual)** your current configuration and install GarudaNvim.

   - If you choose to **delete** your current configuration, the installer will remove your Neovim configuration along with related directories in `~/.local/share`, `~/.local/state`, and `~/.cache`.

   - If you choose to **automatically backup** your configuration, the installer will create backups of your current setup (e.g., `~/.config/nvim.bak`, `~/.local/share/nvim.bak`, etc.), and then proceed with the installation of GarudaNvim.

   - If you choose to **manually backup** your configuration, then go ahead and move (or rename) your current config. After that, run this script again.

3. Once the installation is complete, you’ll see a success message, and you can start using GarudaNvim by opening Neovim.

---

## Features

The **GarudaNvim Installer** and **Uninstaller** comes with several convenient features to ensure an easy and smooth user experience:

1. **Automatic Operating System and Neovim Detection**:
   - The installer detects your operating system (macOS, Linux, or others) and performs system compatibility checks before proceeding.
   - The installer script checks if Neovim is already installed on your system. If it is not found, the script will automatically install Neovim based on the detected operating system, ensuring you have the correct setup for GarudaNvim.

3. **Automatic Configuration Detection**:
   - The installer automatically checks whether a Neovim configuration already exists in the system (i.e., in `~/.config/nvim`).
   - If a configuration is found, the installer will prompt the user with two options:
     - **Backup**: Automatically backs up the existing configuration so it can be restored later if needed.
     - **Delete**: Deletes the existing configuration to install GarudaNvim from scratch.
   
4. **Safe Backup Option**:
   - The installer provides the option to back up the existing configuration before installing GarudaNvim.
   - The backup includes not only `~/.config/nvim` but also other related directories like `~/.local/share/nvim`, `~/.local/state/nvim`, and `~/.cache/nvim`.

5. **Fetching Latest Script Releases**:
   - The installer and uninstaller scripts are fetched directly from the latest script release, not from the latest commit, ensuring more stability and fewer errors.

6. **Complete Uninstallation**:
   - The uninstallation script checks for the presence of GarudaNvim (`~/.config/nvim/lua/garudanvim`) and confirms with the user before proceeding.
   - If confirmed, the script removes all related GarudaNvim configurations and associated directories (`~/.config/nvim`, `~/.local/share/nvim`, `~/.local/state/nvim`, `~/.cache/nvim`) to ensure a clean uninstall.

These features make it easy to manage Neovim setups, providing flexibility for users who may want to switch between different configurations without losing their previous setup.

---

## Uninstallation

### Steps to Uninstall GarudaNvim

If you wish to uninstall GarudaNvim and remove all related configuration, follow these steps:

1. Run this uninstaller script in your terminal using the following command:
   ```sh
   LATEST=$(curl -s https://api.github.com/repos/GarudaNvim/Installer/releases/latest | grep '"tag_name"' | cut -d '"' -f 4)
   wget -q https://raw.githubusercontent.com/GarudaNvim/Installer/$LATEST/uninstallGarudaNvim.sh
   chmod +x uninstallGarudaNvim.sh && { ./uninstallGarudaNvim.sh } || { echo }
   rm -f uninstallGarudaNvim.sh
   ```

2. The script will first check if GarudaNvim is installed by looking for the `garudanvim` directory inside your Neovim configuration (`~/.config/nvim/lua/garudanvim`).
   
   - If found, you will be prompted to confirm the uninstallation process.
   
   - If GarudaNvim is not found, the uninstaller will exit, as there is no GarudaNvim configuration to remove.

3. If you confirm the uninstallation, the following directories will be permanently deleted:
   - `~/.config/nvim`
   - `~/.local/share/nvim`
   - `~/.local/state/nvim`
   - `~/.cache/nvim`

4. Once the uninstallation is complete, you will see a success message.

---

## Feedback and Issues

If you encountered any issues while using **GarudaNvim**, or if you have suggestions for improvements, please raise an issue on the [Installer's Issue Page](https://github.com/GarudaNvim/Installer/issues)

Happy Coding with **GarudaNvim!** 💻
