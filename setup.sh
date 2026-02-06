#!/bin/bash
# Setup script for YouTube to MP3 Converter

echo "=========================================="
echo "YouTube to MP3 Converter - Setup"
echo "=========================================="
echo

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed."
    echo "Please install Homebrew first:"
    echo "/bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

echo "✓ Homebrew is installed"

# Check if FFmpeg is installed
if ! command -v ffmpeg &> /dev/null; then
    echo "FFmpeg is not installed. Installing now..."
    brew install ffmpeg
    if [ $? -eq 0 ]; then
        echo "✓ FFmpeg installed successfully"
    else
        echo "❌ Failed to install FFmpeg"
        exit 1
    fi
else
    echo "✓ FFmpeg is already installed"
fi

# Check Python version
python_version=$(python3 --version 2>&1 | awk '{print $2}')
echo "✓ Python version: $python_version"

# Activate virtual environment and install dependencies
if [ ! -d ".venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv .venv
fi

echo "Installing Python dependencies..."
source .venv/bin/activate
pip install -q -r requirements.txt

echo
echo "=========================================="
echo "✓ Setup complete!"
echo "=========================================="
echo
echo "To run the app, use:"
echo "  ./run.sh"
echo
echo "Or manually:"
echo "  source .venv/bin/activate"
echo "  python youtube_to_mp3.py"

