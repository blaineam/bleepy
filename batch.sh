#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
MEDIAPATH=$1
echo "$SCRIPT_DIR"
find "$MEDIAPATH" -type f \( -iname \*.m4v -o -iname \*.mp4 -o -iname \*.mov  -o -iname \*.webm \) -print0 |
    while IFS= read -r -d '' video; do
        echo "Found video at: $video"
        filename=$(basename "$video")
        cp "$video" "$SCRIPT_DIR/data/input/"
        cd "$SCRIPT_DIR"
        mv "data/input/$filename" "data/input/video.mov"
        python3.9 bleepy.py ./data/output ./data/input/video.mov ./data/input/bleep.mp3 hevc_videotoolbox
        echo "Completed video: $filename"
    done
echo "Completed Bleeping Videos"
cd "$SCRIPT_DIR"
