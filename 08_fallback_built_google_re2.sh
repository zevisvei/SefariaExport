#!/usr/bin/env bash
set -euo pipefail

cd Sefaria-Project
echo "Primary install failed — trying built-google-re2 fallback..."
grep -viE '^\s*google-re2' requirements.txt > req-no-re2.txt || true
pip install -r req-no-re2.txt
pip install built-google-re2
