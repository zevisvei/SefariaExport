#!/usr/bin/env bash
set -euo pipefail

mongosh --quiet --eval 'db.getSiblingDB("sefaria").dropDatabase(); print("✅ DB dropped.")' || true
df -h
