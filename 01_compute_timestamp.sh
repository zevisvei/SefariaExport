#!/usr/bin/env bash
set -euo pipefail

# Compute release timestamp and expose it via GITHUB_OUTPUT
TZ="${TZ_NAME:-Asia/Jerusalem}" date '+%Y-%m-%d_%H-%M' > ts.txt
echo "stamp=$(cat ts.txt)" >> "${GITHUB_OUTPUT}"
