# YouTube to MP3 Converter - App Overview

## 🎨 User Interface

The app features a clean, simple interface with:

### Main Window (600x400)
```
╔═══════════════════════════════════════════════════════════════╗
║                  YouTube to MP3 Converter                     ║
║                                                               ║
║  YouTube URL:                                                 ║
║  [_________________________________________]                 ║
║                                                               ║
║  Save Location:                                               ║
║  [/Users/username/Downloads           ] [Browse...]          ║
║                                                               ║
║  [▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░] 45%                  ║
║  Downloading: 45.0%                                           ║
║                                                               ║
║           [Download and Convert to MP3]                       ║
╚═══════════════════════════════════════════════════════════════╝
```

## 🎯 Key Components

1. **URL Input Field** - Paste any YouTube link here
2. **Location Selector** - Choose where to save your MP3 files
3. **Progress Bar** - Real-time download progress
4. **Status Label** - Shows current operation status
5. **Download Button** - Starts the download and conversion

## 🎨 Status Colors

- **Gray** - Ready to download
- **Blue** - Downloading or preparing
- **Orange** - Converting to MP3
- **Green** - Download complete
- **Red** - Error occurred

## 🔄 Workflow

```
1. User pastes URL
   ↓
2. Click download button
   ↓
3. App downloads video (shows progress)
   ↓
4. FFmpeg extracts audio
   ↓
5. Converts to MP3
   ↓
6. Deletes original video
   ↓
7. Shows success message
   ↓
8. MP3 file ready in chosen location
```

## ✨ Features in Action

### Download States:
- **Ready**: "Ready to download" (gray text)
- **Preparing**: "Preparing download..." (blue text)
- **Downloading**: "Downloading: 45.0%" (blue text + progress bar)
- **Converting**: "Converting to MP3..." (orange text + full progress bar)
- **Complete**: "Download complete!" (green text)
- **Error**: "Download failed" (red text)

### User Experience:
- Button is disabled during download to prevent multiple downloads
- Thread-safe operation - UI stays responsive
- Clear error messages if something goes wrong
- Success dialog shows video title and save location
- URL field clears after successful download

## 🎵 Output

Files are saved as:
```
[Video Title].mp3
```

For example:
```
/Users/username/Downloads/How to Make Pizza - Cooking Tutorial.mp3
```

The original video file (.mp4, .webm, etc.) is automatically deleted.

### Quality Settings:
- **128 kbps** - Standard quality, smaller file size (~1 MB per minute)
- **192 kbps** - Medium quality, balanced (default) (~1.5 MB per minute)
- **320 kbps** - Highest quality, larger file size (~2.5 MB per minute)

