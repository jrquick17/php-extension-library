#!/usr/bin/env bash
# Wrapper script to generate manifest.json using generate-manifest.py
set -e

# Resolve the directory of this script
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Run python script
if command -v python3 >/dev/null 2>&1; then
    python3 "$DIR/generate-manifest.py"
elif command -v python >/dev/null 2>&1; then
    python "$DIR/generate-manifest.py"
else
    echo "Error: Python 3 or Python is required to run the manifest generator." >&2
    exit 1
fi
