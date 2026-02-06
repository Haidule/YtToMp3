# Quick Start Guide

## 🚀 Running the App

The easiest way to run the app:

```bash
./run.sh
```

Or manually:

```bash
source .venv/bin/activate
python youtube_to_mp3.py
```

## 📋 How to Use

1. **Launch the app** - Run `./run.sh` from the terminal
2. **Paste YouTube URL** - Copy and paste any YouTube video link
3. **Choose location** (optional) - Click "Browse..." to change where files are saved
4. **Download** - Click "Download and Convert to MP3"
5. **Wait** - The progress bar will show download and conversion status
6. **Done!** - Your MP3 file will be in the selected location

## 💡 Tips

- The default download location is your Downloads folder
- The app extracts audio at 192kbps MP3 quality
- Video files are automatically deleted, only MP3 is kept
- You can paste multiple URLs one at a time

## 🎯 Features

- ✅ Clean, simple macOS interface
- ✅ Real-time progress updates
- ✅ Automatic audio extraction
- ✅ Custom save location
- ✅ No video files kept (MP3 only)
- ✅ Thread-safe downloads

## ⚠️ Troubleshooting

### App won't start
Make sure FFmpeg is installed:
```bash
ffmpeg -version
```

If not installed:
```bash
brew install ffmpeg
```

### Download fails
- Verify the YouTube URL is valid
- Check your internet connection
- Some videos may be region-restricted

### "Module not found" error
Activate the virtual environment:
```bash
source .venv/bin/activate
pip install -r requirements.txt
```

## 📁 Project Structure

```
YtToMp3/
├── youtube_to_mp3.py   # Main application
├── requirements.txt    # Python dependencies
├── setup.sh           # Setup script (installs FFmpeg)
├── run.sh            # Quick launcher
└── README.md         # Full documentation
```

## 🔧 Advanced


### Change Download Format

The app always outputs MP3, but you can modify the source audio quality by changing line 153:
```python
'format': 'bestaudio/best',  # Downloads best available audio
```

