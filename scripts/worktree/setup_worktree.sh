#!/bin/bash

# Git Worktree Setup Script for Flutter Project
# This script helps set up a new git worktree with all necessary dependencies and gitignored files

set -e

# Default worktree directory
DEFAULT_WORKTREE_DIR="./notion_todo.worktrees"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
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

# Function to check if we're in a Flutter project
check_flutter_project() {
    if [ ! -f "pubspec.yaml" ]; then
        print_error "This doesn't appear to be a Flutter project (no pubspec.yaml found)"
        exit 1
    fi
}

# Function to setup Flutter dependencies
setup_flutter_deps() {
    print_status "Installing Flutter dependencies..."
    if flutter pub get; then
        print_status "Flutter dependencies installed successfully"
    else
        print_error "Failed to install Flutter dependencies"
        exit 1
    fi
}

# Function to setup iOS dependencies
setup_ios_deps() {
    if [ -d "ios" ]; then
        print_status "Setting up iOS dependencies..."
        cd ios
        if command -v pod &> /dev/null; then
            if pod install; then
                print_status "iOS Pods installed successfully"
            else
                print_warning "Failed to install iOS Pods"
            fi
        else
            print_warning "CocoaPods not installed, skipping iOS pod installation"
        fi
        cd ..
    fi
}

# Function to run build_runner if needed
setup_generated_files() {
    if grep -q "build_runner" pubspec.yaml 2>/dev/null; then
        print_status "Running build_runner to generate files..."
        if dart run build_runner build --delete-conflicting-outputs; then
            print_status "Generated files created successfully"
        else
            print_warning "Failed to run build_runner"
        fi
    fi
}

# Helper function to copy file with Copy-on-Write support on macOS
copy_with_cow() {
    local src="$1"
    local dst="$2"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        cp -c "$src" "$dst" 2>/dev/null || cp "$src" "$dst"
    else
        cp "$src" "$dst"
    fi
}

# Function to copy environment files from source worktree
copy_env_files() {
    local source_worktree="$1"
    
    if [ -z "$source_worktree" ] || [ ! -d "$source_worktree" ]; then
        return
    fi
    
    print_status "Copying environment files from $source_worktree..."
    
    # List of common environment files to copy
    env_files=(".env" ".env.local" ".env.development" ".env.production" "env.json" "config.json")
    
    for file in "${env_files[@]}"; do
        if [ -f "$source_worktree/$file" ]; then
            copy_with_cow "$source_worktree/$file" "./$file"
            print_status "Copied $file"
        fi
    done
    
    # Copy any .env* files
    for file in "$source_worktree"/.env*; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            copy_with_cow "$file" "./$filename"
            print_status "Copied $filename"
        fi
    done
    
    # Copy Firebase configuration files
    if [ -f "$source_worktree/ios/Runner/GoogleService-Info.plist" ]; then
        mkdir -p ios/Runner
        copy_with_cow "$source_worktree/ios/Runner/GoogleService-Info.plist" "./ios/Runner/GoogleService-Info.plist"
        print_status "Copied GoogleService-Info.plist"
    fi
    
    if [ -f "$source_worktree/android/app/google-services.json" ]; then
        mkdir -p android/app
        copy_with_cow "$source_worktree/android/app/google-services.json" "./android/app/google-services.json"
        print_status "Copied google-services.json"
    fi
}

# Function to create a new worktree and set it up
create_and_setup_worktree() {
    local branch_name="$1"
    local worktree_path="$2"
    local source_worktree="$3"
    
    if [ -z "$branch_name" ]; then
        print_error "Branch name is required"
        exit 1
    fi
    
    # Use default path if not specified
    if [ -z "$worktree_path" ]; then
        mkdir -p "$DEFAULT_WORKTREE_DIR"
        worktree_path="$DEFAULT_WORKTREE_DIR/$branch_name"
        print_status "Using default path: $worktree_path"
    fi
    
    # Create the worktree
    print_status "Creating new worktree at $worktree_path for branch $branch_name..."
    if ! git worktree add "$worktree_path" -b "$branch_name"; then
        print_error "Failed to create worktree"
        exit 1
    fi
    
    # Move to the new worktree and run setup
    cd "$worktree_path"
    setup_worktree "$source_worktree"
}

# Main setup function
setup_worktree() {
    local source_worktree="$1"
    
    # Check if called from git hook
    if [ -n "$GIT_HOOK_EXECUTION" ]; then
        print_status "Auto-setup triggered by git worktree creation..."
    else
        print_status "Starting worktree setup for Flutter project..."
    fi
    
    # Check if this is a Flutter project
    check_flutter_project
    
    # Setup Flutter dependencies
    setup_flutter_deps
    
    # Setup iOS dependencies
    setup_ios_deps
    
    # Generate files if build_runner is used
    setup_generated_files
    
    # Copy environment files if source worktree is provided
    if [ -n "$source_worktree" ]; then
        copy_env_files "$source_worktree"
    elif [ -n "$GIT_HOOK_EXECUTION" ]; then
        # Auto-detect main worktree when called from hook
        GIT_COMMON_DIR=$(git rev-parse --git-common-dir 2>/dev/null)
        if [ -d "$GIT_COMMON_DIR/../.." ]; then
            MAIN_WORKTREE=$(cd "$GIT_COMMON_DIR/../.." && pwd)
            if [ "$MAIN_WORKTREE" != "$(pwd)" ] && [ -f "$MAIN_WORKTREE/pubspec.yaml" ]; then
                copy_env_files "$MAIN_WORKTREE"
            fi
        fi
    fi
    
    print_status "Worktree setup completed successfully!"
}

# Main script logic
main() {
    case "$1" in
        create)
            # Create a new worktree and set it up
            create_and_setup_worktree "$2" "$3" "$4"
            ;;
        setup)
            # Just run setup in current directory
            setup_worktree "$2"
            ;;
        *)
            echo "Git Worktree Setup Script for Flutter Projects"
            echo ""
            echo "Usage:"
            echo "  $0 create <branch-name> [worktree-path] [source-worktree]"
            echo "    Create a new worktree and set it up"
            echo ""
            echo "  $0 setup [source-worktree]"
            echo "    Set up the current worktree"
            echo ""
            echo "Arguments:"
            echo "  branch-name      Name of the new branch to create"
            echo "  worktree-path    Path where the new worktree will be created"
            echo "                   (default: $DEFAULT_WORKTREE_DIR/<branch-name>)"
            echo "  source-worktree  Optional: Path to existing worktree to copy env files from"
            echo ""
            echo "Examples:"
            echo "  # Create with default path"
            echo "  $0 create feature/new-feature"
            echo ""
            echo "  # Create with custom path"
            echo "  $0 create feature/new-feature ../project-feature"
            echo ""
            echo "  # Setup current worktree"
            echo "  $0 setup"
            ;;
    esac
}

# Run main function
main "$@"
