#!/usr/bin/env python3
"""
YouTube to MP3 Converter - A lightweight macOS GUI app
Downloads YouTube videos and extracts audio as MP3
"""

import tkinter as tk
from tkinter import ttk, filedialog, messagebox
import yt_dlp
import os
import threading
from pathlib import Path


class YouTubeToMP3App:
    def __init__(self, root):
        self.root = root
        self.root.title("YouTube to MP3 Converter")
        self.root.geometry("600x480")
        self.root.resizable(False, False)

        # Default download location
        self.download_path = str(Path.home() / "Downloads")
        self.is_downloading = False

        # Default quality setting (192 kbps)
        self.quality = tk.StringVar(value="192")

        self.setup_ui()

    def setup_ui(self):
        """Create the user interface"""
        # Main frame with padding
        main_frame = ttk.Frame(self.root, padding="20")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))

        # Title
        title_label = ttk.Label(
            main_frame,
            text="YouTube to MP3 Converter",
            font=("Helvetica", 18, "bold")
        )
        title_label.grid(row=0, column=0, columnspan=2, pady=(0, 20))

        # YouTube URL input
        url_label = ttk.Label(main_frame, text="YouTube URL:")
        url_label.grid(row=1, column=0, sticky=tk.W, pady=5)

        self.url_entry = ttk.Entry(main_frame, width=60)
        self.url_entry.grid(row=2, column=0, columnspan=2, pady=(0, 15), sticky=(tk.W, tk.E))
        self.url_entry.focus()

        # Download location
        location_label = ttk.Label(main_frame, text="Save Location:")
        location_label.grid(row=3, column=0, sticky=tk.W, pady=5)

        location_frame = ttk.Frame(main_frame)
        location_frame.grid(row=4, column=0, columnspan=2, pady=(0, 15), sticky=(tk.W, tk.E))

        self.location_entry = ttk.Entry(location_frame, width=50)
        self.location_entry.insert(0, self.download_path)
        self.location_entry.pack(side=tk.LEFT, expand=True, fill=tk.X, padx=(0, 5))

        browse_btn = ttk.Button(location_frame, text="Browse...", command=self.browse_location)
        browse_btn.pack(side=tk.RIGHT)

        # Audio Quality selector
        quality_label = ttk.Label(main_frame, text="Audio Quality:")
        quality_label.grid(row=5, column=0, sticky=tk.W, pady=(5, 5))

        quality_frame = ttk.Frame(main_frame)
        quality_frame.grid(row=6, column=0, columnspan=2, pady=(0, 15), sticky=tk.W)

        ttk.Radiobutton(
            quality_frame,
            text="128 kbps (Standard)",
            variable=self.quality,
            value="128"
        ).pack(side=tk.LEFT, padx=(0, 15))

        ttk.Radiobutton(
            quality_frame,
            text="192 kbps (Medium)",
            variable=self.quality,
            value="192"
        ).pack(side=tk.LEFT, padx=(0, 15))

        ttk.Radiobutton(
            quality_frame,
            text="320 kbps (Highest)",
            variable=self.quality,
            value="320"
        ).pack(side=tk.LEFT)

        # Progress bar
        self.progress_var = tk.DoubleVar()
        self.progress_bar = ttk.Progressbar(
            main_frame,
            variable=self.progress_var,
            maximum=100,
            mode='determinate',
            length=560
        )
        self.progress_bar.grid(row=7, column=0, columnspan=2, pady=(0, 10), sticky=tk.EW)

        # Status label
        self.status_label = ttk.Label(
            main_frame,
            text="Ready to download",
            foreground="gray"
        )
        self.status_label.grid(row=8, column=0, columnspan=2, pady=(0, 20))

        # Download button
        self.download_btn = ttk.Button(
            main_frame,
            text="Download and Convert to MP3",
            command=self.start_download,
            style="Accent.TButton"
        )
        self.download_btn.grid(row=9, column=0, columnspan=2, pady=(0, 10))

        # Configure grid weights
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(0, weight=1)

    def browse_location(self):
        """Open file dialog to select download location"""
        folder = filedialog.askdirectory(initialdir=self.download_path)
        if folder:
            self.download_path = folder
            self.location_entry.delete(0, tk.END)
            self.location_entry.insert(0, folder)

    def update_status(self, message, color="gray"):
        """Update status label"""
        self.status_label.config(text=message, foreground=color)
        self.root.update_idletasks()

    def progress_hook(self, d):
        """Callback for yt-dlp progress updates"""
        if d['status'] == 'downloading':
            # Parse percentage
            if 'total_bytes' in d and d['total_bytes'] > 0:
                downloaded = d.get('downloaded_bytes', 0)
                total = d['total_bytes']
                percentage = (downloaded / total) * 100
                self.progress_var.set(percentage)
                self.update_status(f"Downloading: {percentage:.1f}%", "blue")
            elif '_percent_str' in d:
                # Fallback to yt-dlp's percentage string
                percent_str = d['_percent_str'].strip().replace('%', '')
                try:
                    percentage = float(percent_str)
                    self.progress_var.set(percentage)
                    self.update_status(f"Downloading: {percentage:.1f}%", "blue")
                except ValueError:
                    pass
        elif d['status'] == 'finished':
            self.progress_var.set(100)
            self.update_status("Converting to MP3...", "orange")

    def download_video(self):
        """Download YouTube video and convert to MP3"""
        try:
            url = self.url_entry.get().strip()

            if not url:
                messagebox.showerror("Error", "Please enter a YouTube URL")
                return

            if not os.path.exists(self.download_path):
                messagebox.showerror("Error", "Download location does not exist")
                return

            self.is_downloading = True
            self.download_btn.config(state='disabled')
            self.progress_var.set(0)
            self.update_status("Preparing download...", "blue")

            # Get selected quality
            selected_quality = self.quality.get()

            # Configure yt-dlp options
            ydl_opts = {
                'format': 'bestaudio/best',
                'postprocessors': [{
                    'key': 'FFmpegExtractAudio',
                    'preferredcodec': 'mp3',
                    'preferredquality': selected_quality,
                }],
                'outtmpl': os.path.join(self.download_path, '%(title)s.%(ext)s'),
                'progress_hooks': [self.progress_hook],
                'quiet': False,
                'no_warnings': False,
            }

            # Download and convert
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                info = ydl.extract_info(url, download=True)
                video_title = info.get('title', 'Unknown')

            self.progress_var.set(100)
            self.update_status("Download complete!", "green")

            messagebox.showinfo(
                "Success",
                f"Successfully converted:\n{video_title}\n\nSaved to: {self.download_path}"
            )

            # Reset UI
            self.url_entry.delete(0, tk.END)
            self.progress_var.set(0)
            self.update_status("Ready to download", "gray")

        except Exception as e:
            self.update_status("Download failed", "red")
            messagebox.showerror("Error", f"Failed to download/convert:\n{str(e)}")
            self.progress_var.set(0)

        finally:
            self.is_downloading = False
            self.download_btn.config(state='normal')

    def start_download(self):
        """Start download in a separate thread"""
        if not self.is_downloading:
            thread = threading.Thread(target=self.download_video, daemon=True)
            thread.start()


def check_ffmpeg():
    """Check if ffmpeg is installed"""
    import subprocess
    try:
        subprocess.run(['ffmpeg', '-version'],
                      stdout=subprocess.DEVNULL,
                      stderr=subprocess.DEVNULL,
                      check=True)
        return True
    except (subprocess.CalledProcessError, FileNotFoundError):
        return False


def main():
    """Main entry point"""
    # Check if ffmpeg is installed
    if not check_ffmpeg():
        root = tk.Tk()
        root.withdraw()
        response = messagebox.askyesno(
            "FFmpeg Not Found",
            "FFmpeg is required but not installed.\n\n"
            "Would you like instructions on how to install it?\n\n"
            "You can install it using Homebrew:\n"
            "brew install ffmpeg"
        )
        if response:
            import webbrowser
            webbrowser.open("https://formulae.brew.sh/formula/ffmpeg")
        root.destroy()
        return

    # Create and run the app
    root = tk.Tk()
    app = YouTubeToMP3App(root)
    root.mainloop()


if __name__ == "__main__":
    main()

