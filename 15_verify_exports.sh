#!/usr/bin/env bash
set -euo pipefail

EXPORTS_DIR="${GITHUB_WORKSPACE:-$PWD}/exports"
echo "📁 Full tree of exports directory:"
if command -v tree >/dev/null 2>&1; then
  tree -L 3 "${EXPORTS_DIR}" || true
else
  find "${EXPORTS_DIR}" -type d | head -30
fi

echo ""
echo "📊 Export directory size:"
du -sh "${EXPORTS_DIR}"
du -sh "${EXPORTS_DIR}"/* 2>/dev/null || echo "No subdirectories"

echo ""
echo "📄 File count:"
find "${EXPORTS_DIR}" -type f | wc -l

echo ""
echo "📝 First 20 files:"
find "${EXPORTS_DIR}" -type f | head -20
