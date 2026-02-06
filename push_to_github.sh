#!/bin/bash

# YouTube to MP3 - Complete GitHub Setup Script
# This script will guide you through pushing your project to GitHub

clear
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 GitHub Push Assistant - YouTube to MP3 Converter"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo

cd "$(dirname "$0")"

# Step 1: Initialize Git
echo "📦 Step 1: Initializing Git Repository..."
if [ -d ".git" ]; then
    echo "   ✓ Git repository already exists"
else
    git init
    if [ $? -eq 0 ]; then
        echo "   ✓ Git initialized successfully"
    else
        echo "   ✗ Failed to initialize git"
        exit 1
    fi
fi
echo

# Step 2: Configure Git User
echo "👤 Step 2: Configuring Git User..."
GIT_NAME=$(git config user.name)
GIT_EMAIL=$(git config user.email)

if [ -z "$GIT_NAME" ] || [ -z "$GIT_EMAIL" ]; then
    echo "   ⚠️  Git user not configured"
    echo
    read -p "   Enter your name: " INPUT_NAME
    read -p "   Enter your email: " INPUT_EMAIL

    git config user.name "$INPUT_NAME"
    git config user.email "$INPUT_EMAIL"
    echo "   ✓ Git user configured"
else
    echo "   ✓ Git user already configured"
    echo "     Name:  $GIT_NAME"
    echo "     Email: $GIT_EMAIL"
fi
echo

# Step 3: Add and Commit Files
echo "💾 Step 3: Committing Files..."
git add .
git commit -m "Initial commit: YouTube to MP3 Converter with quality options

Features:
- Clean GUI interface with tkinter
- Support for 128, 192, and 320 kbps quality options
- Real-time progress tracking
- Automatic audio extraction using FFmpeg
- Thread-safe downloads
- Comprehensive documentation" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "   ✓ Files committed successfully"
else
    # Check if commit failed because nothing to commit
    if git diff-index --quiet HEAD --; then
        echo "   ✓ All files already committed"
    else
        echo "   ℹ️  Commit status: $(git status --short | wc -l) files staged"
    fi
fi
echo

# Step 4: Provide GitHub Instructions
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Local repository is ready!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo
echo "🌐 Next: Create GitHub Repository"
echo
echo "1️⃣  Go to: https://github.com/new"
echo "2️⃣  Repository name: YtToMp3"
echo "3️⃣  Make it Public or Private (your choice)"
echo "4️⃣  ⚠️  DO NOT check any boxes (no README, .gitignore, or license)"
echo "5️⃣  Click 'Create repository'"
echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo

read -p "Have you created the repository? (y/n): " REPO_CREATED

if [ "$REPO_CREATED" = "y" ] || [ "$REPO_CREATED" = "Y" ]; then
    echo
    read -p "Enter your GitHub username: " GITHUB_USER

    if [ -z "$GITHUB_USER" ]; then
        echo "❌ Username cannot be empty"
        exit 1
    fi

    echo
    echo "📤 Connecting to GitHub..."

    # Check if remote already exists
    if git remote | grep -q "origin"; then
        echo "   ℹ️  Remote 'origin' already exists, removing..."
        git remote remove origin
    fi

    # Add remote
    git remote add origin "https://github.com/$GITHUB_USER/YtToMp3.git"
    echo "   ✓ Remote added: https://github.com/$GITHUB_USER/YtToMp3.git"

    # Rename branch to main
    git branch -M main
    echo "   ✓ Branch renamed to 'main'"

    echo
    echo "🚀 Pushing to GitHub..."
    echo "   (You may be prompted for authentication)"
    echo

    git push -u origin main

    if [ $? -eq 0 ]; then
        echo
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "🎉 SUCCESS! Your project is now on GitHub!"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo
        echo "📍 Repository URL:"
        echo "   https://github.com/$GITHUB_USER/YtToMp3"
        echo
        echo "📋 Clone command:"
        echo "   git clone https://github.com/$GITHUB_USER/YtToMp3.git"
        echo
    else
        echo
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "⚠️  Push failed - Authentication needed"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo
        echo "GitHub requires a Personal Access Token (PAT)"
        echo
        echo "📝 To create a token:"
        echo "   1. Go to: https://github.com/settings/tokens"
        echo "   2. Click 'Generate new token (classic)'"
        echo "   3. Give it a name: YtToMp3"
        echo "   4. Select scope: ✓ repo"
        echo "   5. Click 'Generate token'"
        echo "   6. Copy the token"
        echo
        echo "Then try pushing again:"
        echo "   git push -u origin main"
        echo "   (Use the token as your password)"
        echo
        echo "OR install GitHub CLI for easier auth:"
        echo "   brew install gh"
        echo "   gh auth login"
        echo "   git push -u origin main"
        echo
    fi
else
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "📝 Manual Push Commands"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo
    echo "After creating the GitHub repository, run:"
    echo
    echo "   git remote add origin https://github.com/YOUR_USERNAME/YtToMp3.git"
    echo "   git branch -M main"
    echo "   git push -u origin main"
    echo
    echo "Replace YOUR_USERNAME with your GitHub username"
    echo
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

