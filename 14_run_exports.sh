#!/usr/bin/env bash
set -euo pipefail

export PYTHONPATH="${GITHUB_WORKSPACE:-$PWD}/Sefaria-Project"
python ./run_exports.py
