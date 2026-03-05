# macOS Setup Guide

This guide helps you set up the Jekyll blog development environment on macOS.

## ⚠️ IMPORTANT: Apple Silicon Users

**Container runtimes have critical issues on Apple Silicon:**
- SCSS compilation fails with `BrokenPipe` errors
- Caused by ARM64 emulation of AMD64 Jekyll images
- No reliable workaround exists

**✅ Solution: Use Native Ruby (required for Apple Silicon)**

## Two Options: Native or Container (Native strongly recommended)

### Option 1: Native Ruby/Jekyll (Recommended)

**Pros:**
- Fastest performance (no virtualization overhead)
- Simplest setup
- Live reload works perfectly

**Setup:**
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Ruby (if not already installed)
brew install ruby

# Add Ruby to PATH (add to ~/.zshrc or ~/.bash_profile)
echo 'export PATH="/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zshrc

# Reload shell
source ~/.zshrc

# Install Bundler
gem install bundler

# Run the site
./run-native.sh
```

### Option 2: Container Runtime

**Pros:**
- Isolated environment
- No Ruby version conflicts
- Matches production environment

**Container Options for Mac:**

#### 1. Docker Desktop (Recommended)
**Industry standard container runtime**

```bash
# Install Docker Desktop
brew install --cask docker

# Or download from https://www.docker.com/products/docker-desktop

# Start Docker Desktop application

# Run the site
./run.sh
```

**Why Docker Desktop?**
- Industry standard and well-supported
- Auto-starts on login
- Good macOS integration
- Works with standard Docker commands
- Free for personal use

**Note:** On Apple Silicon, Docker runs AMD64 images via emulation which may cause SCSS issues. Use native Ruby (`./run-native.sh`) for best results.

#### 2. OrbStack (Alternative)
**Fast, lightweight, Mac-native Docker alternative**

```bash
# Install via Homebrew
brew install orbstack

# Or download from https://orbstack.dev/

# Run the site
./run.sh
```

**Why OrbStack?**
- 5x faster than Docker Desktop on Mac
- Uses Apple's Virtualization framework
- Lower memory usage
- Free for personal use

#### 3. Podman (Alternative)
**Free, open-source, rootless container runtime**

```bash
# Install Podman
brew install podman

# Initialize and start Podman machine
podman machine init
podman machine start

# Run the site
./run.sh
```

**Why Podman?**
- No background daemon (uses less resources)
- Rootless by default (more secure)
- Drop-in Docker replacement
- No subscription required

## Quick Start

Once you've chosen and installed your preferred option:

```bash
# Clone the repository (if not already done)
git clone https://github.com/hfakhraei/hfakhraei.github.io.git
cd hfakhraei.github.io

# For native Ruby:
./run-native.sh

# For container (auto-detects which runtime you have):
./run.sh
```

Visit http://localhost:4000 in your browser.

## Troubleshooting

### Native Ruby Issues

**"Bundle install fails"**
```bash
# Try installing with system Ruby
sudo gem install bundler
bundle install --path .jekyll/gems
```

**"Wrong Ruby version"**
```bash
# Check Ruby version
ruby -v

# Should be 2.7 or higher
# If not, use rbenv or rvm to manage Ruby versions
brew install rbenv
rbenv install 3.2.0
rbenv global 3.2.0
```

### Container Issues

**"does not support required platforms" (Apple Container)**
This means the Jekyll image doesn't have ARM64 support. The script now automatically uses AMD64 with Rosetta emulation, but for best performance:
```bash
# Use native Ruby instead (much faster on Apple Silicon)
./run-native.sh
```

**"Bundler::PermissionError" when using containers**
Fixed! The script now installs gems to `vendor/bundle` inside your project directory instead of system paths. First run may take a few minutes to install dependencies.

**"You have already activated [gem] X, but your Gemfile requires Y"**
This is a gem version conflict. Solutions:
```bash
# Option 1: Clean everything and start fresh (recommended)
./clean.sh
./run.sh

# Option 2: Just remove cached gems
rm -rf vendor/ .bundle
./run.sh

# Option 3: Use native Ruby (avoids container gem conflicts)
./run-native.sh
```

**"Conversion error: Jekyll::Converters::Scss encountered an error" or "BrokenPipe"**
This is a known issue with SCSS compilation in containers on Apple Silicon. The fix:
```bash
# Option 1: Clean and reinstall with sass-embedded (recommended)
./clean.sh
./run.sh

# Option 2: Use native Ruby (best performance, no emulation issues)
./run-native.sh
```

Note: Container mode on Apple Silicon runs with `--no-watch` (no live reload) to avoid pipe issues. For live reload, use native Ruby.

**"No container runtime found"**
- Install one of the container runtimes listed above

**"Podman machine not running"**
```bash
podman machine start
```

**"Port 4000 already in use"**
```bash
# Find and kill the process using port 4000
lsof -ti:4000 | xargs kill -9
```

**"Container permission denied"**
```bash
# For Podman
podman machine stop
podman machine start

# For Docker/Colima
docker context use default
```

**Apple Container slow on Apple Silicon?**
Jekyll images use AMD64 architecture and run via Rosetta emulation. For native performance:
```bash
# Switch to native Ruby
./run-native.sh
```

## Performance Comparison

| Method | Startup | Live Reload | Memory | Disk I/O | Apple Silicon |
|--------|---------|-------------|---------|----------|---------------|
| Native Ruby | ⚡️ Fastest | ✅ Best | 💚 Low | ⚡️ Fastest | ✅ Native |
| OrbStack | 🚀 Fast | ⚠️ No | 💚 Low | 🚀 Fast | ✅ Optimized |
| Docker Desktop | 🐌 Slow | ⚠️ No | ❤️ High | 🐌 Slow | ⚠️ Emulation |
| Podman | ⚡️ Fast | ⚠️ No | 💛 Medium | ⚡️ Fast | ⚠️ Emulation |

## Recommendation

**For Apple Silicon Macs:**
- **Development:** Native Ruby (`./run-native.sh`) - fastest, most responsive
- **Testing/CI:** Apple Container (`./run.sh`) - native performance, isolation

**For Intel Macs:**
- **Development:** Native Ruby (`./run-native.sh`)
- **Testing/CI:** OrbStack or Podman (`./run.sh`)

Native Ruby gives you the best development experience with instant live reloads, but Apple Container provides near-native performance with the benefits of containerization on Apple Silicon.
