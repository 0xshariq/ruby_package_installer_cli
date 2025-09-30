Gem::Specification.new do |spec|
  spec.name          = "package-installer-cli"
  spec.version       = "1.3.0"
  spec.authors       = ["sharique"]
  spec.email         = ["khanshariq92213@gmail.com"]

  spec.summary       = "A cross-platform, interactive CLI to scaffold modern web app templates"
  spec.description   = "A cross-platform, interactive CLI to scaffold modern web application templates with framework, language, UI, bundler support and feature integration. This is a Ruby wrapper around the Node.js implementation."
  spec.homepage      = "https://github.com/0xshariq/ruby_package_installer_cli"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/0xshariq/ruby_package_installer_cli"
  spec.metadata["changelog_uri"] = "https://github.com/0xshariq/ruby_package_installer_cli/blob/main/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "https://github.com/0xshariq/ruby_package_installer_cli/issues"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob([
    "lib/**/*",
    "exe/*",
    "dist/**/*",
    "features/**/*",
    "templates/**/*",
    "template.json",
    "package.json",
    "README.md",
    "CHANGELOG.md",
    "LICENSE*"
  ]).select { |f| File.file?(f) }
  
  spec.bindir        = "exe"
  spec.executables   = ["pi", "package-installer"]
  spec.require_paths = ["lib"]

  # Runtime dependencies
  # None needed as this is just a wrapper around the Node.js implementation
  
  # Development dependencies
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  # Post-install message
  spec.post_install_message = <<~MSG
    🎉 Package Installer CLI has been installed!
    
    📋 Prerequisites:
    - Node.js (>= 18.0.0) must be installed on your system
    - The TypeScript CLI will be automatically executed via Node.js
    
    🚀 Quick start:
      pi create        # Create a new project
      pi analyze       # Analyze existing project
      pi upgrade       # Upgrade CLI and dependencies
    
    📖 For more information: https://github.com/0xshariq/package-installer-cli
  MSG
end