#!/usr/bin/env bash
set -euo pipefail

command -v rg >/dev/null 2>&1 || {
  echo "Installing ripgrep..."
  if command -v apt >/dev/null 2>&1; then sudo apt install -y ripgrep
  elif command -v brew >/dev/null 2>&1; then brew install ripgrep
  else echo "Install ripgrep manually: https://github.com/BurntSushi/ripgrep"; exit 1
  fi
}

command -v rtk >/dev/null 2>&1 || {
  echo "Installing rtk..."
  cargo install rtk 2>/dev/null || {
    echo "rtk not found and cargo not available. Install manually."
  }
}

npm install

echo "Done. opencode config is ready."
