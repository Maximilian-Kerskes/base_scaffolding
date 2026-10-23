#!/bin/bash

SOURCE="${BASH_SOURCE[0]}"

while [[ -L "$SOURCE" ]]; do
	SOURCE_DIR="$(cd -- "$(dirname -- "$SOURCE")" && pwd)"
	SOURCE="$(readlink "$SOURCE")"

	if [[ $SOURCE != /* ]]; then
		SOURCE="$SOURCE_DIR/$SOURCE"
	fi
done

SCRIPT_DIR="$(cd -- "$(dirname -- "$SOURCE")" && pwd)"

set -eu

case "${1:-}" in
--help | -h)
	echo "Usage: $0 <language> <project_name>"
	exit 0
	;;
"")
	echo "Error: missing arguments" >&2
	echo "Usage: $0 <language> <project_name>" >&2
	exit 1
	;;
esac

if [[ $# -ne 2 ]]; then
	echo "Error: wrong number of arguments" >&2
	echo "Usage: $0 <language> <project_name>" >&2
	exit 1
fi

language="$1"
project_name="$2"

TEMPLATE_DIR="$SCRIPT_DIR/templates/$language"

if [[ ! -d "$TEMPLATE_DIR" ]]; then
	echo "Error: language $language not supported" >&2
	exit 1
fi

if [[ -d "$project_name" ]]; then
	echo "Error: project $project_name already exists" >&2
	exit 1
fi

echo "Creating project: $project_name for ${language}..."

echo "Copying files..."
cp -r "$TEMPLATE_DIR" "$project_name"
cd "$project_name"

echo "Renaming project directories to use: $project_name..."
directories=$(find . -type d -name "project_name" -print)

if [[ -z "$directories" ]]; then
	echo "No porject directories found that need renaming"
fi

for directory in $directories; do
	mv -- "$directory" "${directory%/*}/${project_name}"
done

echo "Renaming project file-contents to use: $project_name..."

find . -type f -exec sed -i "s/project_name/$project_name/g" {} +

echo "Setting up git..."
git init >/dev/null

echo "Done!"
