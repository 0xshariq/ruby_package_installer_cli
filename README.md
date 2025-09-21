# � Package Installer CLI - Ruby Gem

[![Gem Version](https://badge.fury.io/rb/package-installer-cli.svg)](https://badge.fury.io/rb/package-installer-cli)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ruby](https://img.shields.io/badge/ruby-%3E%3D2.6.0-red.svg)](https://www.ruby-lang.org/)
[![Node.js](https://img.shields.io/badge/node-%3E%3D18.0.0-brightgreen.svg)](https://nodejs.org/)

A **Ruby wrapper** around the Package Installer CLI - a cross-platform, interactive CLI to scaffold modern web application templates with support for multiple frameworks, languages, and development tools. Create production-ready projects in seconds!

## 📋 Prerequisites

- **Ruby** >= 2.6.0
- **Node.js** >= 18.0.0 (required for the underlying CLI)

## 🚀 Quick Features

- **🎨 Multiple Frameworks**: React, Next.js, Express, Angular, Vue, Rust
- **🔤 Language Support**: TypeScript & JavaScript variants
- **🎭 UI Libraries**: Tailwind CSS, Material-UI, shadcn/ui
- **📦 Smart Package Management**: Auto-detects npm, yarn, pnpm
- **⚡ Lightning Fast**: Optimized template generation with intelligent caching
- **🌈 Beautiful CLI**: Gorgeous terminal interface with real-time analytics
- **🔍 Project Analysis**: Advanced dependency analysis and project insights

## ✨ New Features

- **📊 Enhanced Analytics Dashboard**: Real-time usage analytics with detailed insights
- **🎯 Smart Dependency Updates**: Project-specific dependency management for JS, Python, Rust, Go, Ruby, PHP
- **🚀 Intelligent CLI Upgrades**: Separate upgrade system with breaking change detection
- **💾 .package-installer-cli Folder**: All cache and history stored in dedicated folder
- **📈 Usage Tracking**: Comprehensive command and feature usage tracking
- **⚡ Performance Insights**: Productivity scoring and usage patterns

## 📥 Installation

### Via RubyGems

```bash
gem install package-installer-cli
```

### Via Bundler

Add this line to your application's Gemfile:

```ruby
gem 'package-installer-cli'
```

And then execute:

```bash
bundle install
```

## 🎯 Quick Start

```bash
# Create new project interactively
pi create

# Analyze project with enhanced dashboard
pi analyze

# Update project dependencies only
pi update

# Upgrade CLI to latest version
pi upgrade-cli
```

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [📋 Commands](https://github.com/0xshariq/package-installer-cli/tree/main/docs/commands.md) | Complete command reference with examples |
| [⚡ Features](https://github.com/0xshariq/package-installer-cli/tree/main/docs/features.md) | Detailed feature documentation and usage |
| [🎨 Templates](https://github.com/0xshariq/package-installer-cli/tree/main/docs/templates.md) | Available templates and customization options |
| [🚀 Deployment](https://github.com/0xshariq/package-installer-cli/tree/main/docs/deploy.md) | Deployment options and platform integration |

## 🛠️ Command Overview

| Command | Description | Usage |
|---------|-------------|-------|
| `pi create` | Create new project from templates | `pi create [name]` |
| `pi analyze` | Enhanced project analytics dashboard | `pi analyze [--detailed]` |
| `pi update` | Update project dependencies | `pi update [--latest]` |
| `pi upgrade-cli` | Upgrade CLI to latest version | `pi upgrade-cli` |
| `pi add` | Add features to existing projects | `pi add [feature]` |
| `pi doctor` | Diagnose and fix project issues | `pi doctor` |
| `pi clean` | Clean development artifacts | `pi clean [--all]` |

*For complete command documentation, see [commands](https://github.com/0xshariq/package-installer-cli/tree/main/docs/commands.md)*

## 🏗️ Supported Project Types

| Language/Framework | Templates | Package Managers |
|-------------------|-----------|------------------|
| **JavaScript/TypeScript** | React, Next.js, Express, Angular, Vue | npm, yarn, pnpm |
| **Python** | Django, Flask, FastAPI | pip, poetry |
| **Rust** | Basic, Advanced, Web | cargo |
| **Go** | CLI, Web, API | go mod |
| **Ruby** | Rails, Sinatra | bundler |
| **PHP** | Laravel, Symfony | composer |

*For detailed template information, see [templates](https://github.com/0xshariq/package-installer-cli/tree/main/docs/templates.md)*

## 🎯 System Requirements

- **Ruby**: >= 2.6.0 (for the gem wrapper)
- **Node.js**: >= 18.0.0 (required for the underlying CLI)
- **Operating Systems**: Windows, macOS, Linux
- **Package Managers**: npm, yarn, or pnpm (for Node.js projects)
- **Git**: Required for project initialization

## 🐛 Troubleshooting

### Quick Fixes

```bash
# Ruby Gem Issues
gem uninstall package-installer-cli
gem install package-installer-cli

# Check if Node.js is available
node --version

# Test the Ruby wrapper
pi --help

# Check CLI status
pi doctor
```

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](https://github.com/0xshariq/package-installer-cli/tree/main/CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/0xshariq/package-installer-cli/tree/main/LICENSE) file for details.

## 🔗 Links

- **Ruby Gem**: [package-installer-cli](https://rubygems.org/gems/package-installer-cli)
- **GitHub Repository**: [ruby_package_installer_cli](https://github.com/0xshariq/ruby_package_installer_cli)
- **Original CLI Repository**: [package-installer-cli](https://github.com/0xshariq/package-installer-cli)
- **Issues & Feedback**: [GitHub Issues](https://github.com/0xshariq/ruby_package_installer_cli/issues)

---

💎 **Note**: This Ruby gem is a wrapper around the Node.js implementation. The actual CLI logic is executed via Node.js, so Node.js must be installed on your system.

**Happy coding! 🚀** Create something amazing with Package Installer CLI.
