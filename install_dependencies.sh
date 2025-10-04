#!/bin/bash

# Package Installer CLI - Dependency Installation Script
# This script automatically detects the gem installation type and installs Node.js dependencies

set -e

echo "🔍 Package Installer CLI - Dependency Installation Script"
echo "======================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Node.js is available
check_nodejs() {
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed or not in PATH"
        print_status "Please install Node.js >= 18.0.0 from https://nodejs.org/"
        exit 1
    fi
    
    NODE_VERSION=$(node --version | sed 's/v//')
    print_success "Node.js version: $NODE_VERSION"
}

# Check if npm is available
check_npm() {
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed or not in PATH"
        exit 1
    fi
    
    NPM_VERSION=$(npm --version)
    print_success "npm version: $NPM_VERSION"
}

# Detect package manager
detect_package_manager() {
    if [ -f "pnpm-lock.yaml" ] && command -v pnpm &> /dev/null; then
        echo "pnpm"
    elif [ -f "yarn.lock" ] && command -v yarn &> /dev/null; then
        echo "yarn"
    else
        echo "npm"
    fi
}

# Find gem directory
find_gem_directory() {
    print_status "Detecting gem installation type..."
    
    # Method 1: Check if we're in a bundler context
    if command -v bundle &> /dev/null && bundle info package-installer-cli --path &> /dev/null; then
        GEM_DIR=$(bundle info package-installer-cli --path)
        INSTALL_TYPE="bundler"
        print_success "Detected Bundler installation: $GEM_DIR"
        return 0
    fi
    
    # Method 2: Try gem which command
    if command -v gem &> /dev/null && gem which package_installer_cli &> /dev/null; then
        GEM_FILE=$(gem which package_installer_cli)
        GEM_DIR=$(dirname "$(dirname "$GEM_FILE")")
        
        # Determine installation type based on path
        if [[ "$GEM_DIR" == *".bundle"* ]] || [[ "$GEM_DIR" == *"vendor/bundle"* ]]; then
            INSTALL_TYPE="local"
        elif [[ "$GEM_DIR" == *"$HOME"* ]] || [[ "$GEM_DIR" == *"$(whoami)"* ]]; then
            INSTALL_TYPE="user"
        else
            INSTALL_TYPE="global"
        fi
        
        print_success "Detected $INSTALL_TYPE installation: $GEM_DIR"
        return 0
    fi
    
    # Method 3: Search in common gem locations
    GEM_ENV_DIR=$(gem environment gemdir 2>/dev/null || echo "")
    if [ -n "$GEM_ENV_DIR" ]; then
        GEM_SEARCH=$(find "$GEM_ENV_DIR/gems" -name "package-installer-cli-*" -type d 2>/dev/null | head -1)
        if [ -n "$GEM_SEARCH" ]; then
            GEM_DIR="$GEM_SEARCH"
            INSTALL_TYPE="global"
            print_success "Found global installation: $GEM_DIR"
            return 0
        fi
    fi
    
    print_error "Could not locate package-installer-cli gem"
    print_status "Please ensure the gem is installed: gem install package-installer-cli"
    exit 1
}

# Install dependencies
install_dependencies() {
    print_status "Installing Node.js dependencies..."
    
    if [ ! -f "$GEM_DIR/package.json" ]; then
        print_error "package.json not found in $GEM_DIR"
        exit 1
    fi
    
    cd "$GEM_DIR"
    
    PACKAGE_MANAGER=$(detect_package_manager)
    print_status "Using package manager: $PACKAGE_MANAGER"
    
    case $PACKAGE_MANAGER in
        "pnpm")
            pnpm install --prod
            ;;
        "yarn")
            yarn install --production
            ;;
        *)
            npm install --production
            ;;
    esac
    
    print_success "Dependencies installed successfully!"
}

# Verify installation
verify_installation() {
    print_status "Verifying installation..."
    
    if [ -d "$GEM_DIR/node_modules" ]; then
        MODULE_COUNT=$(ls -1 "$GEM_DIR/node_modules" | wc -l)
        print_success "Found $MODULE_COUNT Node.js modules"
    else
        print_warning "node_modules directory not found"
    fi
    
    # Test CLI command
    if command -v pi &> /dev/null; then
        print_success "CLI command 'pi' is available"
        pi --version 2>/dev/null || print_warning "Could not get version (this is normal)"
    else
        print_warning "CLI command 'pi' not found in PATH"
        print_status "You may need to add gem binaries to your PATH"
    fi
}

# Main execution
main() {
    echo
    print_status "Starting dependency installation process..."
    
    check_nodejs
    check_npm
    find_gem_directory
    install_dependencies
    verify_installation
    
    echo
    print_success "✅ Installation complete!"
    echo
    print_status "Next steps:"
    echo "  • Run 'pi --help' to see available commands"
    echo "  • Run 'pi doctor' to diagnose any issues"
    echo "  • Run 'pi create' to create your first project"
    echo
    print_status "Installation details:"
    echo "  • Type: $INSTALL_TYPE"
    echo "  • Location: $GEM_DIR"
    echo "  • Package Manager: $(detect_package_manager)"
    echo
}

# Run main function
main "$@"