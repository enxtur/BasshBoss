#!/usr/bin/env bash
# BashBoss Installer
# Symlinks all executable scripts from the 'scripts/' directory to ~/.local/bin

set -euo pipefail

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "🚀 Installing BashBoss scripts..."

# Destination directory (~/.local/bin is standard and usually in PATH)
BIN_DIR="$HOME/.local/bin"

# Create bin directory if needed
if [[ ! -d "$BIN_DIR" ]]; then
  echo "Creating $BIN_DIR..."
  mkdir -p "$BIN_DIR"
fi

# Warn if ~/.local/bin is not in PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  echo -e "${YELLOW}Warning: $BIN_DIR is not in your \$PATH.${NC}"
  echo "    Add this line to your ~/.bashrc, ~/.zshrc, or shell config:"
  echo ""
  echo "        export PATH=\"\$PATH:$BIN_DIR\""
  echo ""
  echo "    Then run: source ~/.zshrc  (or restart your terminal)"
  echo ""
fi

# Resolve the repo root directory (where install.sh lives)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$REPO_DIR/scripts"

# Check if scripts directory exists
if [[ ! -d "$SCRIPTS_DIR" ]]; then
  echo -e "${RED}Error: 'scripts/' directory not found in $REPO_DIR${NC}" >&2
  exit 1
fi

installed_count=0

# Loop through all files in the scripts/ directory
for script in "$SCRIPTS_DIR"/*; do
  [[ -f "$script" ]] || continue  # Skip if no files

  filename="$(basename "$script")"

  # Skip hidden files and files with .sh extension
  [[ "$filename" == .* ]] && continue
  [[ "$filename" == *.sh ]] && continue

  # Only install executable files
  if [[ -x "$script" ]]; then
    target="$BIN_DIR/$filename"

    # Create or update symlink
    if ln -sf "$script" "$target" 2>/dev/null; then
      echo -e "${GREEN}✓${NC} Installed: $filename"
      ((installed_count++))
    else
      echo -e "${YELLOW}⚠ Updated symlink: $filename${NC}"
    fi
  fi
done

if (( installed_count == 0 )); then
  echo -e "${RED}No executable scripts found in scripts/ directory!${NC}"
  echo "Make sure:"
  echo "  • Your scripts are inside the 'scripts/' folder"
  echo "  • They are executable: chmod +x scripts/your-script"
  echo "  • They do not have a .sh extension"
  exit 1
fi

echo ""
echo -e "${GREEN}🎉 BashBoss installed successfully! ($installed_count scripts linked)${NC}"
echo ""
echo "You can now run commands like:"
echo "    kill-port 3000"
echo "    kill-port 3000 8080 5000"
echo ""
echo "Enjoy being the BashBoss! 💪"

exit 0