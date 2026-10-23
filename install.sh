#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="$HOME/.local/lib/scaffold"
BIN_DIR="$HOME/.local/bin"
LINK="$BIN_DIR/scaffold"

install() {
	echo "Installing scaffold..."

	mkdir -p "$INSTALL_DIR" "$BIN_DIR"

	cp "$SCRIPT_DIR/scaffold.sh" "$INSTALL_DIR/"
	cp -r "$SCRIPT_DIR/templates/" "$INSTALL_DIR/"

	chmod +x "$INSTALL_DIR/scaffold.sh"

	ln -sfn "$INSTALL_DIR/scaffold.sh" "$LINK"

	echo "Installation complete!"
	echo "Run 'scaffold --help' for usage."
	echo "Make sure $BIN_DIR is in your PATH."
}

uninstall() {
	echo "Uninstalling scaffold..."

	rm -f "$LINK"
	rm -rf "$INSTALL_DIR"

	echo "Uninstallation complete!"
}

usage() {
	echo "Usage: $0 [--uninstall | --help]"
}

case "${1:-}" in
"")
	install
	;;
--uninstall)
	uninstall
	;;
--help | -h)
	usage
	;;
*)
	echo "Error: unknown argument: $1" >&2
	usage >&2
	exit 1
	;;
esac
