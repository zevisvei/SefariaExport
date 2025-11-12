#!/usr/bin/env bash
set -euo pipefail

cd Sefaria-Project/sefaria
cp local_settings_example.py local_settings.py
python ../../configure_local_settings.py

echo ""
echo "📄 Checking local_settings.py content:"
grep -E "(SEFARIA_EXPORT_PATH|MONGO_HOST|MONGO_PORT|SEFARIA_DB)" local_settings.py || true
