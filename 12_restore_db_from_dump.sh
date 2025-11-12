#!/usr/bin/env bash
set -euo pipefail

if [ ! -d mongo_dump_pkg/sefaria ]; then
  echo "❌ mongo_dump_pkg/sefaria not found"; exit 1
fi
mongorestore --host 127.0.0.1 --port 27017 --drop --db sefaria "mongo_dump_pkg/sefaria"
python ./ensure_history_collection.py
echo "✅ Mongo restore complete."
