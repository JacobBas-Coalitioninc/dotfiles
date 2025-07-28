#!/bin/bash

# =============================================================================
# DOTFILES SETUP SCRIPT
# =============================================================================
# This script sets up symbolic links for Neovim and WezTerm configurations
# on Unix systems (macOS and Linux)

set -e  # Exit on any error

echo "🚀 Setting up dotfiles configuration..."

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

# Function to create backup of existing config
create_backup() {
    local config_path="$1"
    local backup_path="${config_path}.backup.$(date +%Y%m%d_%H%M%S)"
    
    if [[ -e "$config_path" ]]; then
        print_warning "Existing configuration found at $config_path"
        print_status "Creating backup at $backup_path"
        mv "$config_path" "$backup_path"
        return 0
    fi
    return 1
}

# Function to create symbolic link
create_symlink() {
    local source="$1"
    local target="$2"
    local target_dir="$(dirname "$target")"
    
    # Create target directory if it doesn't exist
    if [[ ! -d "$target_dir" ]]; then
        print_status "Creating directory: $target_dir"
        mkdir -p "$target_dir"
    fi
    
    # Create backup if target exists
    create_backup "$target"
    
    # Create symbolic link
    print_status "Creating symbolic link: $source -> $target"
    ln -sf "$source" "$target"
    
    if [[ -L "$target" ]]; then
        print_success "Linked '$source' to '$target'"
    else
        print_error "Failed to create symbolic link: $source -> $target"
        return 1
    fi
}

# Function to setup Neovim configuration
setup_neovim() {
    print_status "Setting up Neovim configuration..."
    
    local nvim_source="$PWD/nvim"
    local nvim_target="$HOME/.config/nvim"
    
    if [[ ! -d "$nvim_source" ]]; then
        print_error "Neovim configuration directory not found: $nvim_source"
        return 1
    fi
    
    create_symlink "$nvim_source" "$nvim_target"
    
    # Check if Neovim is installed
    if ! command -v nvim &> /dev/null; then
        print_warning "Neovim is not installed. Please install it first:"
        echo "  macOS: brew install neovim"
        echo "  Linux: Follow https://github.com/neovim/neovim/wiki/Installing-Neovim"
    else
        print_success "Neovim configuration setup complete"
    fi
}

# Function to setup WezTerm configuration
setup_wezterm() {
    print_status "Setting up WezTerm configuration..."
    
    local wezterm_source="$PWD/wezterm"
    local wezterm_target="$HOME/.config/wezterm"
    
    if [[ ! -d "$wezterm_source" ]]; then
        print_warning "WezTerm configuration directory not found: $wezterm_source"
        print_status "Skipping WezTerm setup..."
        return 0
    fi
    
    create_symlink "$wezterm_source" "$wezterm_target"
    
    # Check if WezTerm is installed
    if ! command -v wezterm &> /dev/null; then
        print_warning "WezTerm is not installed. You can install it from:"
        echo "  https://wezfurlong.org/wezterm/install/"
    else
        print_success "WezTerm configuration setup complete"
    fi
}

# Function to verify installations
verify_setup() {
    print_status "Verifying setup..."
    
    local errors=0
    
    # Check Neovim config
    if [[ -L "$HOME/.config/nvim" ]]; then
        print_success "Neovim configuration linked"
    else
        print_error "Neovim configuration not properly linked"
        ((errors++))
    fi
    
    # Check WezTerm config (if exists)
    if [[ -d "$PWD/wezterm" ]]; then
        if [[ -L "$HOME/.config/wezterm" ]]; then
            print_success "WezTerm configuration linked"
        else
            print_error "WezTerm configuration not properly linked"
            ((errors++))
        fi
    fi
    
    # Check Kitty config (if exists)
    if [[ -d "$PWD/kitty" ]]; then
        if [[ -L "$HOME/.config/kitty" ]]; then
            print_success "Kitty configuration linked"
        else
            print_error "Kitty configuration not properly linked"
            ((errors++))
        fi
    fi
    
    # Check Helix config (if exists)
    if [[ -d "$PWD/helix" ]]; then
        if [[ -L "$HOME/.config/helix" ]]; then
            print_success "Helix configuration linked"
        else
            print_error "Helix configuration not properly linked"
            ((errors++))
        fi
    fi
    
    if [[ $errors -eq 0 ]]; then
        print_success "All configurations verified successfully!"
    else
        print_error "Found $errors configuration issue(s)"
        return 1
    fi
}

# Main execution
main() {
    echo "=========================================="
    echo "  DOTFILES SETUP SCRIPT"
    echo "=========================================="
    echo ""
    
    # Ensure we're in the dotfiles directory
    if [[ ! -f "init_config.sh" ]]; then
        print_error "Please run this script from the dotfiles directory"
        exit 1
    fi
    
    # Setup configurations
    setup_neovim
    setup_wezterm
    setup_kitty
    setup_helix
    
    # Install Neovim plugins
    install_neovim_plugins
    
    # Verify setup
    verify_setup
    
    echo ""
    echo "=========================================="
    print_success "Setup complete! 🎉"
    echo "=========================================="
    echo ""
    echo "Next steps:"
    echo "1. Restart your terminal"
    echo "2. Open Neovim: nvim"
    echo "3. Wait for Lazy.nvim to install plugins (first time only)"
    echo "4. Enjoy your new development environment!"
    echo ""
    echo "For detailed documentation, see:"
    echo "  - README.md (this repository)"
    echo "  - nvim/README.md (Neovim configuration)"
    echo ""
}

# Run main function
main "$@"
