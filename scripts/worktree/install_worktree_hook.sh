#!/bin/bash

# Install/Uninstall script for Git worktree auto-setup hook
# This script sets up git hooks and aliases for automatic Flutter project setup

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[i]${NC} $1"
}

# Function to install the post-checkout hook
install_hook() {
    local git_dir=$(git rev-parse --git-dir 2>/dev/null)
    
    if [ -z "$git_dir" ]; then
        print_error "Not in a git repository. Please run this from within a git repository."
        exit 1
    fi
    
    local hooks_dir="$git_dir/hooks"
    local hook_file="$hooks_dir/post-checkout"
    
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    local hook_source="$SCRIPT_DIR/hooks/post-checkout"
    
    # Create hooks directory if it doesn't exist
    mkdir -p "$hooks_dir"
    
    # Check if hook already exists
    if [ -f "$hook_file" ]; then
        print_warning "post-checkout hook already exists."
        echo -n "Do you want to (b)ackup and replace, (a)ppend, or (s)kip? [b/a/s]: "
        read -r choice
        
        case "$choice" in
            b|B)
                backup_file="$hook_file.backup.$(date +%Y%m%d_%H%M%S)"
                cp "$hook_file" "$backup_file"
                print_status "Backed up existing hook to: $backup_file"
                cp "$hook_source" "$hook_file"
                chmod +x "$hook_file"
                print_status "Installed new post-checkout hook"
                ;;
            a|A)
                echo "" >> "$hook_file"
                echo "# Flutter worktree auto-setup addition" >> "$hook_file"
                cat "$hook_source" | sed '1d' >> "$hook_file"  # Skip shebang line
                print_status "Appended to existing post-checkout hook"
                ;;
            s|S)
                print_info "Skipping hook installation"
                ;;
            *)
                print_error "Invalid choice. Skipping hook installation"
                ;;
        esac
    else
        # Install new hook
        cp "$hook_source" "$hook_file"
        chmod +x "$hook_file"
        print_status "Installed post-checkout hook"
    fi
}

# Function to install git aliases
install_aliases() {
    print_info "Installing git aliases for worktree management..."
    
    # Get the absolute path to setup_worktree.sh
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    SETUP_SCRIPT="$SCRIPT_DIR/setup_worktree.sh"
    
    if [ ! -f "$SETUP_SCRIPT" ]; then
        print_error "setup_worktree.sh not found in $SCRIPT_DIR"
        return 1
    fi
    
    # Install local aliases (for this repository only)
    git config alias.wtadd "!f() { git worktree add \"\$@\" && cd \"\${@: -1}\" && \"$SETUP_SCRIPT\" setup; }; f"
    git config alias.wtcreate "!f() { git worktree add -b \"\$1\" \"\$2\" && cd \"\$2\" && \"$SETUP_SCRIPT\" setup; }; f"
    git config alias.wtsetup "!\"$SETUP_SCRIPT\" setup"
    
    print_status "Installed local git aliases:"
    print_info "  git wtadd <path> [<branch>]     - Add worktree and run setup"
    print_info "  git wtcreate <branch> <path>    - Create new branch worktree and setup"
    print_info "  git wtsetup [source-worktree]   - Run setup in current worktree"
    
    echo ""
    echo -n "Do you want to install these aliases globally? [y/N]: "
    read -r choice
    
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        git config --global alias.wtadd "!f() { git worktree add \"\$@\" && cd \"\${@: -1}\" && if [ -f ./setup_worktree.sh ]; then ./setup_worktree.sh setup; elif [ -f ../setup_worktree.sh ]; then ../setup_worktree.sh setup; else echo 'setup_worktree.sh not found'; fi; }; f"
        git config --global alias.wtcreate "!f() { git worktree add -b \"\$1\" \"\$2\" && cd \"\$2\" && if [ -f ./setup_worktree.sh ]; then ./setup_worktree.sh setup; elif [ -f ../setup_worktree.sh ]; then ../setup_worktree.sh setup; else echo 'setup_worktree.sh not found'; fi; }; f"
        git config --global alias.wtsetup "!if [ -f ./setup_worktree.sh ]; then ./setup_worktree.sh setup \"\$@\"; elif [ -f ../setup_worktree.sh ]; then ../setup_worktree.sh setup \"\$@\"; else echo 'setup_worktree.sh not found'; fi"
        print_status "Installed global git aliases"
    fi
}

# Function to uninstall everything
uninstall() {
    print_info "Uninstalling worktree auto-setup..."
    
    local git_dir=$(git rev-parse --git-dir 2>/dev/null)
    
    if [ -n "$git_dir" ]; then
        local hook_file="$git_dir/hooks/post-checkout"
        
        if [ -f "$hook_file" ]; then
            # Check if it's our hook
            if grep -q "Git post-checkout hook for auto-setup of Flutter worktrees" "$hook_file" 2>/dev/null; then
                rm "$hook_file"
                print_status "Removed post-checkout hook"
                
                # Check for backup files
                if ls "$hook_file".backup.* 1> /dev/null 2>&1; then
                    print_info "Found backup hooks. You may want to restore one:"
                    ls -la "$hook_file".backup.*
                fi
            else
                print_warning "post-checkout hook exists but doesn't appear to be ours. Skipping removal."
            fi
        fi
    fi
    
    # Remove local aliases
    git config --unset alias.wtadd 2>/dev/null || true
    git config --unset alias.wtcreate 2>/dev/null || true
    git config --unset alias.wtsetup 2>/dev/null || true
    print_status "Removed local git aliases"
    
    echo -n "Do you want to remove global aliases too? [y/N]: "
    read -r choice
    
    if [[ "$choice" =~ ^[Yy]$ ]]; then
        git config --global --unset alias.wtadd 2>/dev/null || true
        git config --global --unset alias.wtcreate 2>/dev/null || true
        git config --global --unset alias.wtsetup 2>/dev/null || true
        print_status "Removed global git aliases"
    fi
}

# Main function
main() {
    echo "╔════════════════════════════════════════════════╗"
    echo "║  Git Worktree Auto-Setup Installation Script  ║"
    echo "╚════════════════════════════════════════════════╝"
    echo ""
    
    case "$1" in
        install)
            print_info "Installing worktree auto-setup..."
            install_hook
            install_aliases
            echo ""
            print_status "Installation complete!"
            echo ""
            echo "You can now use:"
            echo "  • ${GREEN}git worktree add <path> [<branch>]${NC} - Auto-setup via hook"
            echo "  • ${GREEN}git wtadd <path> [<branch>]${NC}        - Add worktree with setup"
            echo "  • ${GREEN}git wtcreate <branch> <path>${NC}       - Create branch & worktree"
            echo "  • ${GREEN}git wtsetup [source-worktree]${NC}      - Run setup manually"
            ;;
            
        uninstall)
            uninstall
            print_status "Uninstallation complete!"
            ;;
            
        *)
            echo "Usage: $0 {install|uninstall}"
            echo ""
            echo "Commands:"
            echo "  install    - Install git hooks and aliases for auto-setup"
            echo "  uninstall  - Remove hooks and aliases"
            echo ""
            echo "This script will:"
            echo "  1. Install a post-checkout hook for automatic setup"
            echo "  2. Create git aliases for enhanced worktree commands"
            echo "  3. Enable automatic Flutter dependency installation"
            echo "  4. Copy environment files from main worktree"
            exit 1
            ;;
    esac
}

# Check dependencies
check_dependencies() {
    if ! command -v git &> /dev/null; then
        print_error "git is not installed"
        exit 1
    fi
    
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    
    if [ ! -f "$SCRIPT_DIR/setup_worktree.sh" ]; then
        print_error "setup_worktree.sh not found in $SCRIPT_DIR"
        exit 1
    fi
    
    if [ ! -f "$SCRIPT_DIR/hooks/post-checkout" ]; then
        print_error "hooks/post-checkout not found in $SCRIPT_DIR"
        exit 1
    fi
}

# Run dependency check
check_dependencies

# Run main function
main "$@"