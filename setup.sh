#!/bin/bash

# Step 1: Run restore-packages.sh inside ./packages
if [[ -f "./packages/restore-packages.sh" ]]; then
    echo "##########################"
    echo "### Restoring packages ###"
    echo "##########################"

    cd packages/ && bash ./restore-packages.sh
    cd ..
else
    echo "Error: ./packages/restore-packages.sh not found!"
    exit 1
fi

# Step 2: Run stow-system.sh
if [[ -f "./stow-system.sh" ]]; then
    echo "#######################"
    echo "### Stowing configs ###"
    echo "#######################"
   
    bash ./stow-system.sh
else
    echo "Error: ./stow-system.sh not found!"
    exit 1
fi

echo "Setup completed successfully!"

