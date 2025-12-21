#!/usr/bin/env bash
# restore-packages.sh
# Installs packages listed in pacman-packages.txt and aur-packages.txt

set -e  # Exit on error
set -u  # Treat unset variables as errors

# Check if pacman-packages.txt exists
if [ -f "pacman-packages.txt" ]; then
    echo "Restoring Pacman packages..."
    sudo pacman -Syu --needed - < pacman-packages.txt
else
    echo "pacman-packages.txt not found, skipping Pacman packages."
fi

# Check if aur-packages.txt exists
if [ -f "aur-packages.txt" ]; then
    echo "Restoring AUR packages..."
    yay -S --needed - < aur-packages.txt
else
    echo "aur-packages.txt not found, skipping AUR packages."
fi

echo "All packages restored!"
