#!/usr/bin/env bash
set -euo pipefail

# This script finds directories named exactly "Hebrew" inside exports/
# For each such directory, it moves its contents one level up, then removes the empty dir.

ROOT_DIR="${GITHUB_WORKSPACE:-$PWD}"
EXPORTS_DIR="${ROOT_DIR}/exports"

if [ ! -d "${EXPORTS_DIR}" ]; then
  echo "❌ exports directory not found at: ${EXPORTS_DIR}" >&2
  exit 1
fi

cd "${EXPORTS_DIR}"

echo "📦 Flattening directories named 'Hebrew' under $(pwd) ..."

MATCHES=$(find . -type d -name "Hebrew" -print)
COUNT=$(printf "%s\n" "$MATCHES" | sed '/^$/d' | wc -l | tr -d ' ')
if [ "$COUNT" -eq 0 ]; then
  echo "ℹ️  No 'Hebrew' directories found."
else
  printf "%s\n" "$MATCHES" | sed '/^$/d' | while IFS= read -r dir; do
    [ -z "$dir" ] && continue
    parent_dir=$(dirname -- "$dir")
    echo "🔧 Processing: $dir -> $parent_dir"
    # Move non-hidden files/dirs up one level; suppress errors if empty
    mv "$dir"/* "$parent_dir"/ 2>/dev/null || true
    # Try removing the now-empty directory
    if rmdir "$dir" 2>/dev/null; then
      echo "✅ Removed: $dir"
    else
      echo "⚠️  Skipped (not empty or hidden files present): $dir"
    fi
  done
  echo "✅ All 'Hebrew' folders processed."
fi
