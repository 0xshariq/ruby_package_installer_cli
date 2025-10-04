require 'fileutils'
require 'rubygems'

module PackageInstallerCli
  class PostInstall
    def self.run
      gem_root = find_gem_root
      package_json = File.join(gem_root, 'package.json')
      
      unless File.exist?(package_json)
        puts "⚠️  Warning: package.json not found in gem directory: #{gem_root}"
        return
      end

      # Check if Node.js is available
      unless command_exists?('node')
        puts "\n❌ Node.js is not installed or not in PATH"
        print_manual_instructions(gem_root)
        return
      end

      # Try to install dependencies automatically
      puts "\n📦 Installing Node.js dependencies automatically..."
      
      Dir.chdir(gem_root) do
        package_manager = detect_package_manager
        install_command = get_install_command(package_manager)
        
        puts "   Using #{package_manager}: #{install_command}"
        
        success = system(install_command)
        
        if success
          puts "✅ Dependencies installed successfully!"
          puts "🚀 Package Installer CLI is ready to use!"
        else
          puts "\n❌ Automatic dependency installation failed"
          print_manual_instructions(gem_root)
        end
      end
    end

    private

    def self.command_exists?(command)
      system("which #{command} > /dev/null 2>&1") || 
      system("where #{command} > /dev/null 2>&1") ||
      system("command -v #{command} > /dev/null 2>&1")
    end

    def self.detect_package_manager
      return 'pnpm' if File.exist?('pnpm-lock.yaml') && command_exists?('pnpm')
      return 'yarn' if File.exist?('yarn.lock') && command_exists?('yarn')
      return 'npm'  # Default fallback
    end

    def self.get_install_command(package_manager)
      case package_manager
      when 'pnpm' then 'pnpm install --prod'
      when 'yarn' then 'yarn install --production'
      else 'npm install --production'
      end
    end

    def self.find_gem_root
      # Method 1: Try to find using the current file location
      current_gem_root = File.expand_path('../../../', __FILE__)
      return current_gem_root if File.exist?(File.join(current_gem_root, 'package.json'))

      # Method 2: Use Gem.find_files to locate the gem
      begin
        gem_spec = Gem::Specification.find_by_name('package-installer-cli')
        return gem_spec.gem_dir if gem_spec && File.exist?(File.join(gem_spec.gem_dir, 'package.json'))
      rescue Gem::LoadError
        # Gem not found via specification
      end

      # Method 3: Search through gem paths
      gem_paths = Gem.path + [Gem.default_dir]
      gem_paths.each do |gem_path|
        potential_dirs = Dir.glob(File.join(gem_path, 'gems', 'package-installer-cli-*'))
        potential_dirs.each do |dir|
          return dir if File.exist?(File.join(dir, 'package.json'))
        end
      end

      # Method 4: Try bundler context (for local installations)
      if defined?(Bundler) && Bundler.rubygems.loaded_specs('package-installer-cli')
        spec = Bundler.rubygems.loaded_specs('package-installer-cli')
        return spec.gem_dir if spec && File.exist?(File.join(spec.gem_dir, 'package.json'))
      end

      # Fallback: return the calculated path from current file
      current_gem_root
    end

    def self.print_manual_instructions(gem_root)
      installation_type = detect_installation_type(gem_root)
      
      puts <<~INSTRUCTIONS

        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        📋 MANUAL INSTALLATION REQUIRED (#{installation_type.upcase} INSTALLATION)
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

        The Package Installer CLI requires Node.js dependencies to function properly.
        Please follow these steps to complete the installation:

        1️⃣  Install Node.js (if not already installed):
           • Download from: https://nodejs.org/
           • Required version: Node.js >= 18.0.0
           • Verify: node --version

        2️⃣  Navigate to the gem directory:
           cd "#{gem_root}"

        3️⃣  Install dependencies using your preferred package manager:
           
           Using npm (recommended):
           npm install --production
           
           Using pnpm (if you have it):
           pnpm install --prod
           
           Using yarn (if you have it):
           yarn install --production

        4️⃣  Verify installation by running:
           pi --version

        💡 ALTERNATIVE METHODS:

        #{get_alternative_methods(installation_type)}

        🔍 TROUBLESHOOTING TIPS:
           • Check Node.js: node --version
           • Check npm: npm --version
           • Find gem location: gem which package_installer_cli
           • Check gem info: gem info package-installer-cli
           
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
        📖 For more help, visit: https://github.com/0xshariq/ruby_package_installer_cli
        ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

      INSTRUCTIONS
    end

    def self.detect_installation_type(gem_root)
      if gem_root.include?('.bundle') || gem_root.include?('vendor/bundle')
        'local/bundler'
      elsif gem_root.include?(Gem.user_dir) || gem_root.include?(ENV['HOME'] || '')
        'user/local'  
      else
        'system/global'
      end
    end

    def self.get_alternative_methods(installation_type)
      case installation_type
      when 'local/bundler'
        <<~METHODS
        For Bundler installations:
           bundle exec pi --version
           
           Or find gem directory:
           GEM_DIR=$(bundle info package-installer-cli --path)
           cd "$GEM_DIR" && npm install --production
        METHODS
      when 'user/local'
        <<~METHODS
        For user-local installations:
           # Find gem directory automatically
           GEM_DIR=$(gem which package_installer_cli | xargs dirname | xargs dirname)
           cd "$GEM_DIR" && npm install --production
        METHODS
      else
        <<~METHODS
        For system/global installations:
           # May require sudo for some operations
           sudo npm install --production (in gem directory)
           
           # Or use gem environment
           cd $(gem environment gemdir)/gems/package-installer-cli-*/
           npm install --production
        METHODS
      end
    end
  end
end

# Run the post-install hook
skip_install = ENV['PACKAGE_INSTALLER_CLI_SKIP_NPM'] == '1'
unless skip_install
  PackageInstallerCli::PostInstall.run
end
