#!/bin/bash

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
INSTALL_DIR="$HOME/.local/lib/scaffold"
BIN_DIR="$HOME/.local/bin"

echo "Installing scaffold..."

mkdir -p "$INSTALL_DIR" "$BIN_DIR"

cp "$SCRIPT_DIR/scaffold.sh" "$INSTALL_DIR/"
cp -r "$SCRIPT_DIR/templates/" "$INSTALL_DIR/"

chmod +x "$INSTALL_DIR/scaffold.sh"

ln -sfn "$INSTALL_DIR/scaffold.sh" "$BIN_DIR/scaffold"

echo "Installation Complete!"
echo "Run 'scaffold --help' for usage"
echo "Make sure $BIN_DIR is in your PATH"
