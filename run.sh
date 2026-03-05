#!/bin/bash

# Jekyll version matching Gemfile
export JEKYLL_VERSION=3.8

# Detect container runtime (Docker Desktop or alternatives)
CONTAINER_CMD=""

if command -v docker &> /dev/null; then
    CONTAINER_CMD="docker"
elif command -v podman &> /dev/null; then
    CONTAINER_CMD="podman"
else
    echo "Error: No container runtime found!"
    echo ""
    echo "Please install Docker Desktop:"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "  brew install --cask docker"
        echo "  Or download from: https://www.docker.com/products/docker-desktop"
    else
        echo "  https://www.docker.com/products/docker-desktop"
    fi
    exit 1
fi

# Detect OS and set bundle cache path
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    BUNDLE_CACHE="$HOME/.jekyll-bundle-cache"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    # Windows (Git Bash or Cygwin)
    BUNDLE_CACHE="/c/Users/$USER/.jekyll-bundle-cache"
else
    # Linux
    BUNDLE_CACHE="$HOME/.jekyll-bundle-cache"
fi

# Create cache directory if it doesn't exist
mkdir -p "$BUNDLE_CACHE"

# Start Podman machine if needed (Docker Desktop starts automatically)
if [[ "$CONTAINER_CMD" == "podman" ]] && [[ "$OSTYPE" == "darwin"* ]]; then
    if ! podman machine list 2>/dev/null | grep -q "Currently running"; then
        echo "Starting Podman machine..."
        podman machine start 2>/dev/null || true
        sleep 2
    fi
fi

# Warn if running on Apple Silicon
if [[ "$OSTYPE" == "darwin"* ]] && uname -m | grep -q "arm64"; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "⚠️  WARNING: Running Docker on Apple Silicon"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "Known issues with Docker + Apple Silicon + Jekyll:"
    echo "  - SCSS may have BrokenPipe errors (emulation issues)"
    echo "  - No live reload (must manually refresh browser)"
    echo "  - Slower performance due to AMD64 emulation"
    echo ""
    echo "🎯 RECOMMENDED: Use native Ruby instead"
    echo "   ./run-native.sh"
    echo ""
    echo "   Setup takes 5 minutes:"
    echo "   brew install ruby"
    echo "   gem install bundler"
    echo "   ./run-native.sh"
    echo ""
    echo "Press Ctrl+C to cancel, or wait 5 seconds to continue with Docker..."
    echo ""
    sleep 5
fi

echo "Starting Jekyll server with ${CONTAINER_CMD}..."
echo "Jekyll version: $JEKYLL_VERSION"
echo "Project directory: $PWD"
echo ""
echo "Server will be available at: http://localhost:4000"
echo "Press Ctrl+C to stop the server"
echo ""

# Run container with Docker Desktop
# Use named volume to cache gems between runs
VOLUME_NAME="jekyll-gems-3.8"

echo "Using gem cache volume: $VOLUME_NAME"
echo ""

$CONTAINER_CMD run \
    --name jekyll \
    --rm \
    -p 4000:4000 \
    -v "$PWD:/srv/jekyll" \
    -v "$VOLUME_NAME:/usr/local/bundle" \
    -it \
    jekyll/jekyll:$JEKYLL_VERSION \
    sh -c "bundle install && bundle exec jekyll serve --host 0.0.0.0 --force_polling"
