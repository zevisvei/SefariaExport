#!/usr/bin/env bash
set -euo pipefail

: "${GH_TOKEN:?GH_TOKEN env is required}"

TAG="${TS_STAMP}"
shopt -s nullglob

# Chercher les fichiers à uploader
FILES=( "sefaria-exports-${TS_STAMP}.tar.zst.part-"* )
if [ "${#FILES[@]}" -eq 0 ]; then
  FILES=( "sefaria-exports-${TS_STAMP}.tar.zst" )
fi

if [ "${#FILES[@]}" -eq 0 ]; then
  echo "❌ No files to upload!"
  exit 1
fi

echo "📤 Found ${#FILES[@]} file(s) to upload"

for f in "${FILES[@]}"; do
  echo "Uploading: $f ($(stat -c%s "$f" | numfmt --to=iec-i --suffix=B))"
  for attempt in {1..5}; do
    if gh release upload "$TAG" "$f" --clobber; then
      echo "✅ Uploaded: $f"
      break
    fi
    sleep $((2**attempt))
    echo "🔄 Retry $attempt for $f..."
    if [[ $attempt -eq 5 ]]; then
      echo "❌ Failed to upload $f after 5 attempts"
      exit 1
    fi
  done
done

echo "✅ All files uploaded successfully"
