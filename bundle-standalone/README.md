# Package Installer CLI - Standalone Bundle

## Installation

### Option 1: Install to PATH (Recommended)
```bash
# Copy to system directory
sudo cp pi /usr/local/bin/

# Or add current directory to PATH
export PATH="$PATH:$(pwd)"
```

Now you can use `pi` from anywhere:
```bash
pi create my-nextjs-app
pi analyze
pi update
pi add auth
```

### Option 2: Run directly from bundle
```bash
./pi --help
./pi create my-app
```

## Requirements
- Node.js 22+ must be installed

## What's Included
- `pi` - Executable wrapper script with intelligent fallback
- `cli-with-packages.js` - Bundled CLI (Primary, includes all npm packages)
- `dist/` - Fallback CLI (Plan B, requires Node.js)
- `templates/` - All project templates (React, Next.js, Vue, etc.)
- `features/` - Feature definitions (auth, database, AWS, etc.)
- `template.json` - Configuration

## How It Works
The `pi` wrapper uses a smart dual-path approach:
1. **Primary**: Runs `cli-with-packages.js` (fastest, all packages bundled)
2. **Fallback**: If primary fails, uses `dist/index.js` (Plan B)
3. **Error**: Shows clear message if both paths fail

## For Package Maintainers

### Python (PyPI)
```python
import subprocess
subprocess.run([f"{package_dir}/pi", "create", "my-app"])
```

### Rust (Crates.io)
```rust
Command::new(&format!("{}/pi", package_dir))
    .args(&["create", "my-app"])
    .spawn()
```

### Ruby (RubyGems)
```ruby
system("#{package_dir}/pi create my-app")
```

## Note
All npm packages are pre-bundled in `cli-with-packages.js` for optimal performance.
The `dist/` folder provides a reliable fallback mechanism.
Only Node.js 22+ runtime is required.
