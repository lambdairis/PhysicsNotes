#!/bin/bash

SOURCE_DIR="./lib"

find "$SOURCE_DIR" -type f | while read -r file; do
  dir=$(dirname "$file")
  name=$(basename "$file")
  lower=$(echo "$name" | tr 'A-Z' 'a-z')
  target="$dir/$lower"

  if [[ "$name" != "$lower" ]]; then
    cp -f "$file" "$target"
    echo "Copied to lowercase: $target"
  fi
done
