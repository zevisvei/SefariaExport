#!/usr/bin/env bash
set -euo pipefail

export PYTHONPATH="${GITHUB_WORKSPACE:-$PWD}/Sefaria-Project"
if ! python ./check_export_module.py; then
  echo "❌ Failed to load export module"
fi
