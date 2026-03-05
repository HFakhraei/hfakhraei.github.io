#!/bin/bash

# Clean Jekyll build artifacts and gem caches

echo "Cleaning Jekyll build artifacts and gem caches..."
echo ""

# Remove Jekyll build directory
if [ -d "_site" ]; then
    echo "Removing _site/"
    rm -rf _site
fi

# Remove Sass cache
if [ -d ".sass-cache" ]; then
    echo "Removing .sass-cache/"
    rm -rf .sass-cache
fi

# Remove Jekyll cache
if [ -d ".jekyll-cache" ]; then
    echo "Removing .jekyll-cache/"
    rm -rf .jekyll-cache
fi

# Remove vendor bundle (container gems)
if [ -d "vendor" ]; then
    echo "Removing vendor/ (container gem cache)"
    rm -rf vendor
fi

# Remove bundle config
if [ -d ".bundle" ]; then
    echo "Removing .bundle/"
    rm -rf .bundle
fi

# Remove native Jekyll gems
if [ -d ".jekyll" ]; then
    echo "Removing .jekyll/ (native gem cache)"
    rm -rf .jekyll
fi

# Remove Docker gem cache volume (if using Docker)
if command -v docker &> /dev/null; then
    VOLUME_NAME="jekyll-gems-3.8"
    if docker volume ls | grep -q "$VOLUME_NAME"; then
        echo "Removing Docker gem cache volume: $VOLUME_NAME"
        docker volume rm "$VOLUME_NAME" 2>/dev/null || echo "  (volume in use or already removed)"
    fi
fi

echo ""
echo "✓ Cleanup complete!"
echo ""
echo "Note: Using Jekyll 3.8.5 (as specified in Gemfile)"
echo ""
echo "Next steps:"
echo "  - For native Ruby: ./run-native.sh"
echo "  - For container: ./run.sh"
