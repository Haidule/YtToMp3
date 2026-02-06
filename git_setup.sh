#!/bin/bash
# Automated Git Setup and Push Script for YtToMp3

cd "$(dirname "$0")"

echo "🚀 YouTube to MP3 Converter - Git Setup"
echo "========================================"
echo

# Initialize git if not already done
if [ ! -d ".git" ]; then
    echo "📦 Initializing git repository..."
    git init
    echo "✓ Git initialized"
else
    echo "✓ Git already initialized"
fi

# Check git config
if [ -z "$(git config user.name)" ]; then
    echo
    echo "⚠️  Git user not configured. Setting up..."
    read -p "Enter your name: " git_name
    read -p "Enter your email: " git_email
    git config user.name "$git_name"
    git config user.email "$git_email"
    echo "✓ Git user configured"
fi

echo
echo "📁 Adding files to git..."
git add .

echo "✓ Files staged"

echo
echo "💾 Creating commit..."
git commit -m "Initial commit: YouTube to MP3 Converter with quality options

Features:
- Clean GUI interface with tkinter
- Support for 128, 192, and 320 kbps quality options
- Real-time progress tracking
- Automatic audio extraction using FFmpeg
- Thread-safe downloads
- Comprehensive documentation
- Easy setup scripts"

echo "✓ Commit created"

echo
echo "========================================"
echo "📤 Ready to push to GitHub!"
echo "========================================"
echo
echo "Next steps:"
echo
echo "1️⃣  Create a new repository on GitHub:"
echo "   → Go to: https://github.com/new"
echo "   → Repository name: YtToMp3"
echo "   → Make it Public or Private"
echo "   → DO NOT add README, .gitignore, or license (we have them)"
echo "   → Click 'Create repository'"
echo
echo "2️⃣  Connect and push your code:"
echo "   After creating the repo, run these commands:"
echo
echo "   # Replace YOUR_USERNAME with your GitHub username"
echo "   git remote add origin https://github.com/YOUR_USERNAME/YtToMp3.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo
echo "   OR if you use SSH:"
echo "   git remote add origin git@github.com:YOUR_USERNAME/YtToMp3.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo
echo "========================================"
echo "✅ Your code is committed and ready!"
echo "========================================"

