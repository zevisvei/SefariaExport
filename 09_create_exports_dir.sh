#!/usr/bin/env bash
set -euo pipefail

EXPORTS_DIR="${GITHUB_WORKSPACE:-$PWD}/exports"
mkdir -p "${EXPORTS_DIR}"
echo "SEFARIA_EXPORT_BASE=${EXPORTS_DIR}" >> "${GITHUB_ENV}"
