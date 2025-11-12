#!/usr/bin/env bash
set -euo pipefail

# This script removes all directories named exactly "english" inside exports/
# Run it from repo root or anywhere; it will cd into the exports directory.

ROOT_DIR="${GITHUB_WORKSPACE:-$PWD}"
EXPORTS_DIR="${ROOT_DIR}/exports"

if [ ! -d "${EXPORTS_DIR}" ]; then
  echo "❌ exports directory not found at: ${EXPORTS_DIR}" >&2
  exit 1
fi

cd "${EXPORTS_DIR}"

echo "🧹 Removing directories named 'English' under $(pwd) ..."

# Find and remove directories named exactly 'english' (case-sensitive as requested)
# Use -depth to ensure we delete from the leaves upward
MATCHES=$(find . -depth -type d -name "English" -print)
COUNT=$(printf "%s\n" "$MATCHES" | sed '/^$/d' | wc -l | tr -d ' ')
if [ "$COUNT" -eq 0 ]; then
  echo "ℹ️  No 'English' directories found."
else
  printf "%s\n" "$MATCHES" | sed '/^$/d' | while IFS= read -r d; do
    echo " - Deleting: $d"
    rm -rf -- "$d"
  done
  echo "✅ Deleted $COUNT directory(ies) named 'English'."
fi
