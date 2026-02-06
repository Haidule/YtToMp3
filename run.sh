#!/bin/bash
# Launcher script for YouTube to MP3 Converter

cd "$(dirname "$0")"

# Activate virtual environment
source .venv/bin/activate

# Run the app
python youtube_to_mp3.py

