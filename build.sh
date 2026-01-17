#!/usr/bin/env bash
# Render build script - This will be used if you set Build Command to: ./build.sh

set -e

echo "🔧 Starting build process..."

# Upgrade pip
echo "📦 Upgrading pip..."
pip install --upgrade pip

# Install dependencies with binary-only flag
echo "📥 Installing dependencies (binary wheels only)..."
pip install --only-binary=:all: -r requirements.txt

echo "✅ Build complete!"
