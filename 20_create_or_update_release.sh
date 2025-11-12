#!/usr/bin/env bash
set -euo pipefail

: "${GH_TOKEN:?GH_TOKEN env is required}"

TAG="${TS_STAMP}"
TITLE="Sefaria Export ${TS_STAMP}"
NOTES=$(cat <<EOF
Combined Sefaria exports (zstd --ultra -22 -T0).

Restore:
  # if split into parts
  cat sefaria-exports-${TS_STAMP}.tar.zst.part-* > combined.tar.zst && tar --zstd -xf combined.tar.zst
  # if single file
  tar --zstd -xf sefaria-exports-${TS_STAMP}.tar.zst
EOF
)

# Create the release if it does not exist
if ! gh release view "$TAG" >/dev/null 2>&1; then
  gh release create "$TAG" -t "$TITLE" -n "$NOTES"
fi
