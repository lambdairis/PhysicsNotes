#!/bin/bash

# Set the hardcoded source directory
SOURCE_DIR="./lib"

# Ensure the directory exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Directory '$SOURCE_DIR' does not exist."
  exit 1
fi

# Recursively find all files (in reverse order to avoid directory rename issues)
find "$SOURCE_DIR" -type f | sort -r | while read -r file; do
  dir=$(dirname "$file")
  filename=$(basename "$file")
  lowercase=$(echo "$filename" | tr 'A-Z' 'a-z')
  target="$dir/$lowercase"

  # Only proceed if filename has uppercase characters
  if [[ "$filename" != "$lowercase" ]]; then
    # If target name exists and is different, remove or warn (optional)
    if [[ "$file" == "$target" ]]; then
      continue  # Skip if same
    fi

    # Use temporary name to bypass case-insensitive conflicts
    temp="${dir}/.__tmp_$(date +%s%N)"

    mv "$file" "$temp" && mv "$temp" "$target"
    echo "Renamed: '$file' → '$target'"
  fi
done
