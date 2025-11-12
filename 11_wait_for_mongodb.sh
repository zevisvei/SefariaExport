#!/usr/bin/env bash
set -euo pipefail

for i in {1..60}; do
  if nc -z 127.0.0.1 27017; then
    echo "✅ MongoDB reachable"; exit 0
  fi
  echo "⏳ Waiting for MongoDB..."; sleep 2
done
echo "❌ MongoDB not reachable in time" >&2
exit 1
