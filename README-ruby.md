# 💎 Package Installer CLI - Ruby Gem

[![Gem Version](https://badge.fury.io/rb/package-installer-cli.svg)](https://badge.fury.io/rb/package-installer-cli)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Ruby](https://img.shields.io/badge/ruby-%3E%3D2.6.0-red.svg)](https://www.ruby-lang.org/)

A **Ruby wrapper** around the Package Installer CLI - a cross-platform, interactive CLI to scaffold modern web application templates with support for multiple frameworks, languages, and development tools.

## 🚀 About

This is a Ruby gem that wraps the original TypeScript/Node.js implementation of the Package Installer CLI. It allows Ruby developers to easily install and use the CLI tool without having to deal with npm or Node.js package management directly.

## 📋 Prerequisites

- **Ruby** >= 2.6.0
- **Node.js** >= 18.0.0 (required for the underlying CLI)

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

## 🎯 Usage

After installation, you can use the CLI with the same commands as the original:

```bash
# Create new project interactively
pi create

# Analyze project with enhanced dashboard
pi analyze

# Update project dependencies
pi upgrade

# Show help
pi --help
package-installer --help
```

## ✨ Features

All features from the original Package Installer CLI are available:

- **🎨 Multiple Frameworks**: React, Next.js, Express, Angular, Vue, Rust
- **🔤 Language Support**: TypeScript & JavaScript variants  
- **🎭 UI Libraries**: Tailwind CSS, Material-UI, shadcn/ui
- **📦 Smart Package Management**: Auto-detects npm, yarn, pnpm
- **⚡ Lightning Fast**: Optimized template generation with intelligent caching
- **🌈 Beautiful CLI**: Gorgeous terminal interface with real-time analytics
- **🔍 Project Analysis**: Advanced dependency analysis and project insights

## 🛠️ Development

After checking out the repo, run `bundle install` to install dependencies.

### Building the Gem

```bash
# Build the gem
rake build

# Install locally for testing
rake install_local

# Check dependencies
rake check_deps

# Test the CLI wrapper
rake test_cli

# Prepare for release
rake prepare_release
```

### Running Tests

```bash
bundle exec rspec
```

### Code Quality

```bash
bundle exec rubocop
```

## 📦 Publishing

To publish a new version:

1. Update the version number in `package-installer-cli.gemspec`
2. Build the gem: `rake build`
3. Push to RubyGems: `gem push package-installer-cli-*.gem`

## 🤝 Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/0xshariq/package-installer-cli.

## 📄 License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## 🔗 Links

- **Original CLI**: https://github.com/0xshariq/package-installer-cli
- **NPM Package**: https://www.npmjs.com/package/@0xshariq/package-installer
- **Documentation**: https://github.com/0xshariq/package-installer-cli#readme

---

💎 **Note**: This Ruby gem is a wrapper around the Node.js implementation. The actual CLI logic is executed via Node.js, so Node.js must be installed on your system.