# Development Setup Guide

Quick reference for running this Jekyll blog locally.

## ⚠️ Important: Apple Silicon Users

**SCSS compilation does not work reliably in containers on Apple Silicon** due to emulation issues with the sass compiler. You will encounter `BrokenPipe` errors.

**You MUST use native Ruby on Mac:**

```bash
./run-native.sh
```

## 🚀 Quick Start

### macOS (Apple Silicon or Intel)

```bash
# Install Ruby if needed
brew install ruby

# Add to PATH (add to ~/.zshrc)
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Install bundler
gem install bundler

# Run Jekyll
./run-native.sh
```

Visit http://localhost:4000

## 📋 Options

### Option 1: Native Ruby (Recommended)
**Best for:** Development, live reload, Apple Silicon
```bash
./run-native.sh
```

**Pros:**
- ⚡️ Fastest performance
- ✅ Live reload works perfectly
- 💚 Low memory usage
- 🔥 Native Apple Silicon support

**Cons:**
- Requires Ruby installed

---

### Option 2: Container (Docker Desktop)
**Best for:** CI/CD, testing, isolated environments (not recommended for Mac development)
```bash
./run.sh
```

**Pros:**
- 📦 No Ruby installation needed
- 🔒 Isolated environment
- 🌍 Cross-platform

**Cons:**
- ⚠️ No live reload (must refresh manually)
- 🐌 Slower on Apple Silicon (emulation)
- 💾 Higher memory usage

---

## 🧹 Troubleshooting

### Clean Everything
```bash
./clean.sh
```

Removes all build artifacts, caches, and gem files. Start fresh!

### Common Issues

**Gem version conflicts:**
```bash
./clean.sh
./run.sh  # or ./run-native.sh
```

**SCSS/BrokenPipe errors:**
```bash
# Use native Ruby (best solution)
./run-native.sh
```

**Port 4000 already in use:**
```bash
lsof -ti:4000 | xargs kill -9
```

---

## 📚 Full Documentation

- **Mac Setup:** See [SETUP_MAC.md](SETUP_MAC.md)
- **Project Guide:** See [CLAUDE.md](CLAUDE.md)

---

## 🎯 Recommendation

**On Mac?** → Use `./run-native.sh`

Native Ruby gives you the best development experience with instant live reloads and full Apple Silicon optimization.

Containers are great for CI/CD but add complexity and reduce performance for local development.
