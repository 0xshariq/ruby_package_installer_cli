# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

desc "Build and install the gem locally"
task :install_local do
  sh "gem build package-installer-cli.gemspec"
  sh "gem install package-installer-cli-*.gem"
end

desc "Clean up built gems"
task :clean do
  sh "rm -f package-installer-cli-*.gem"
end

desc "Prepare release"
task :prepare_release => [:clean, :build] do
  puts "✅ Gem built successfully!"
  puts "📦 To publish to RubyGems, run: gem push package-installer-cli-*.gem"
end

desc "Check if Node.js dependencies are available"
task :check_deps do
  puts "🔍 Checking dependencies..."
  
  # Check if Node.js is available
  if system('node --version > /dev/null 2>&1')
    node_version = `node --version`.strip
    puts "✅ Node.js found: #{node_version}"
  else
    puts "❌ Node.js not found. Please install Node.js >= 18.0.0"
    exit 1
  end
  
  # Check if dist/index.js exists
  if File.exist?('dist/index.js')
    puts "✅ CLI files found at dist/index.js"
  else
    puts "❌ CLI files not found. Please run 'npm run build' first"
    exit 1
  end
  
  puts "🎉 All dependencies are ready!"
end

desc "Test the CLI wrapper"
task :test_cli => :check_deps do
  puts "🧪 Testing CLI wrapper..."
  system('ruby exe/pi --help')
end