#!/bin/bash

# Run Jekyll natively without containers (recommended for Mac)
# This requires Ruby and Bundler to be installed

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 Starting Jekyll server (native mode)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if Ruby is installed
if ! command -v ruby &> /dev/null; then
    echo "❌ Error: Ruby is not installed."
    echo ""
    echo "Install Ruby with Homebrew:"
    echo "  brew install ruby"
    echo ""
    echo "Then add to PATH (add to ~/.zshrc):"
    echo '  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"'
    exit 1
fi

# Check if bundle is installed
if ! command -v bundle &> /dev/null; then
    echo "❌ Error: Bundler is not installed."
    echo ""
    echo "Install it with:"
    echo "  gem install bundler"
    exit 1
fi

# Check if dependencies are installed
if [ ! -d ".jekyll/gems" ] && [ ! -d "vendor/bundle" ]; then
    echo "📦 Installing dependencies (first time setup)..."
    bundle install --path .jekyll/gems
    echo ""
fi

echo "✅ Server will be available at: http://localhost:4000"
echo "✅ Live reload enabled - changes auto-refresh browser"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Run Jekyll with live reload
bundle exec jekyll serve --livereload
