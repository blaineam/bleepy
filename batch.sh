#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "$SCRIPT_DIR"
echo "$1"
cd "$1"
for file in *.webm; do
    echo "$file"
    filename=$(basename "$file")
    cp "$file" "$SCRIPT_DIR/data/input/"
    cd "$SCRIPT_DIR"
    mv "data/input/$filename" "data/input/video.mov"
    docker compose run --rm bleepy
    echo "Completed video: $filename"
    cd "$1"
done
cd "$SCRIPT_DIR"
