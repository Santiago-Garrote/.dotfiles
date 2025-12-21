#!/bin/bash

# Path to the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Path to the .setupignore file
IGNORE_FILE="$SCRIPT_DIR/.setupignore"

# Loop through all directories in the current folder
for dir in "$SCRIPT_DIR"/*/; do
    # Remove trailing slash
    dir="${dir%/}"
    # Get folder name only
    folder_name="${dir##*/}"

    # Skip if folder is in .setupignore
    if [[ -f "$IGNORE_FILE" ]] && grep -Fxq "$folder_name" "$IGNORE_FILE"; then
        echo "Skipping $folder_name"
        continue
    fi

    # Run stow for the folder
    echo "Stowing $folder_name"
    # UNCOMMENT FOR PROD: stow "$folder_name"
done
