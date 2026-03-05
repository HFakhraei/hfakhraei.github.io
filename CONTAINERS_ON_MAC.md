# Why Containers Don't Work Well on Mac

## The Problem

Jekyll + SCSS + Containers + Apple Silicon = 💥 BrokenPipe errors

### Root Cause

1. **Jekyll Docker images** are built for AMD64/x86_64 architecture
2. **Apple Silicon** (M1/M2/M3/M4) uses ARM64 architecture
3. **Rosetta 2 emulation** translates AMD64 → ARM64 at runtime
4. **SCSS compilation** uses the `sassc` C library with pipe-based IPC
5. **Pipes break** during emulation, causing `Errno::EPIPE`

### What We Tried

❌ Using `sass-embedded` gem (still uses pipes)
❌ Using `--platform linux/amd64` flag (still emulated)
❌ Pre-building SCSS (build step also fails)
❌ Disabling watch mode (compilation still breaks)
❌ Using different Jekyll versions (same issue)

### Technical Details

```
Error trace:
sass/compiler/connection.rb:83:in `write': Broken pipe (Errno::EPIPE)
  from sass/compiler/connection.rb:83:in `write_protobuf'
  from sass/compiler/connection.rb:52:in `send_message'
  from sass/compiler.rb:45:in `compile_string'
  from jekyll-sass-converter/...
```

The sass compiler spawns a subprocess and communicates via pipes. When running under Rosetta emulation, these pipes randomly fail during write operations.

## The Solution

### ✅ Use Native Ruby

Native Ruby runs directly on ARM64 without emulation:

```bash
# Install Ruby via Homebrew
brew install ruby

# Add to PATH
echo 'export PATH="/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Install dependencies and run
gem install bundler
./run-native.sh
```

**Benefits:**
- ⚡️ 3-5x faster than containers
- ✅ SCSS works perfectly
- 🔥 Live reload works
- 💚 Lower memory usage
- 🎯 Native ARM64 execution

### When Containers Work

Containers work fine on:
- **Linux** (native execution, no emulation)
- **Intel Mac** (native AMD64)
- **Windows with WSL2** (native execution)

## Alternatives Evaluated

### Docker Desktop
- **Pros:** Industry standard, well-supported, auto-starts
- **Cons:** Runs AMD64 images with emulation on Apple Silicon, same BrokenPipe issues

### Podman
- **Pros:** Lightweight, rootless, no daemon
- **Cons:** Runs AMD64 images with emulation on Apple Silicon, same BrokenPipe issues

### OrbStack
- **Pros:** Fastest container runtime on Mac, optimized
- **Cons:** Runs AMD64 images with emulation on Apple Silicon, same BrokenPipe issues

## Why Not ARM64 Jekyll Images?

ARM64 Jekyll images don't exist (or are outdated) because:
1. Jekyll's dependencies include native C extensions
2. Many gems don't have ARM64 builds
3. The Jekyll Docker image maintainers prioritize AMD64

## Bottom Line

**On Apple Silicon Mac: Use native Ruby. Containers are not viable for Jekyll development.**

The 5 minutes to install Ruby will save you hours of debugging container issues.
