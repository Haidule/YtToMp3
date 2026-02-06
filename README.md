# YouTube to MP3 Converter

A lightweight macOS GUI application built with Python that downloads YouTube videos and converts them to MP3 audio files.

## Features

- Simple and clean GUI interface
- Paste any YouTube URL to download
- Automatically extracts audio and saves as MP3
- Choose custom download location
- Progress bar with status updates
- No MP4 video files are kept (only MP3 output)

## Requirements

- Python 3.7+
- FFmpeg (for audio extraction)

## Installation

### 1. Install FFmpeg

FFmpeg is required for audio extraction. Install it using Homebrew:

```bash
brew install ffmpeg
```

### 2. Set up Python environment

Create and activate a virtual environment (recommended):

```bash
python3 -m venv .venv
source .venv/bin/activate
```

### 3. Install Python dependencies

```bash
pip install -r requirements.txt
```

## Usage

Run the application:

```bash
python youtube_to_mp3.py
```

Or make it executable:

```bash
chmod +x youtube_to_mp3.py
./youtube_to_mp3.py
```

### How to use:

1. Launch the app
2. Paste a YouTube URL into the text field
3. (Optional) Click "Browse..." to change the download location
4. Click "Download and Convert to MP3"
5. Wait for the download and conversion to complete
6. Your MP3 file will be saved in the specified location

## Troubleshooting

### "FFmpeg Not Found" error

Make sure FFmpeg is installed and available in your PATH:

```bash
ffmpeg -version
```

If not installed, install it with:

```bash
brew install ffmpeg
```

### Download fails

- Check your internet connection
- Verify the YouTube URL is valid and accessible
- Some videos may be restricted or unavailable in your region

## License

This is a personal project for educational purposes.

## Notes

- The app only keeps the final MP3 file, not the original video
- Default download location is your Downloads folder
- Default audio quality is 192kbps (Medium)
- Quality options: 128 kbps (Standard), 192 kbps (Medium), 320 kbps (Highest)

