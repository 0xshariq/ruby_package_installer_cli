#!/usr/bin/env ruby

require 'open3'
require 'json'

module PackageInstallerCli
  VERSION = "3.2.0"
  
  class << self
    def run(args = ARGV)
      # Check if Node.js is available
      unless node_available?
        puts "❌ Error: Node.js is required but not found."
        puts "Please install Node.js (>= 18.0.0) from https://nodejs.org/"
        exit 1
      end
      
      # Check Node.js version
      node_version = get_node_version
      if node_version && !compatible_node_version?(node_version)
        puts "⚠️  Warning: Node.js version #{node_version} detected."
        puts "Recommended: Node.js >= 18.0.0"
        puts "Some features may not work correctly."
        puts
      end
      
      # Get the path to the dist/index.js file relative to this gem
      cli_path = File.join(gem_root, 'dist', 'index.js')
      
      unless File.exist?(cli_path)
        puts "❌ Error: CLI files not found at #{cli_path}"
        puts "Please ensure the package is properly installed."
        exit 1
      end
      
      # Execute the Node.js CLI with the provided arguments
      begin
        exec('node', cli_path, *args)
      rescue Errno::ENOENT
        puts "❌ Error: Failed to execute Node.js command."
        puts "Please ensure Node.js is properly installed and accessible."
        exit 1
      rescue SystemExit => e
        exit e.status
      rescue Exception => e
        puts "❌ Unexpected error: #{e.message}"
        exit 1
      end
    end
    
    private
    
    def gem_root
      File.expand_path('..', __dir__)
    end
    
    def node_available?
      system('node --version > /dev/null 2>&1')
    end
    
    def get_node_version
      stdout, stderr, status = Open3.capture3('node --version')
      if status.success?
        stdout.strip.gsub(/^v/, '')
      else
        nil
      end
    rescue
      nil
    end
    
    def compatible_node_version?(version)
      begin
        # Simple version comparison for major version >= 18
        major_version = version.split('.').first.to_i
        major_version >= 18
      rescue
        false
      end
    end
  end
end