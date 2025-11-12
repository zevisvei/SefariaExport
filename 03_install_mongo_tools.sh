#!/usr/bin/env bash
set -euo pipefail

TOOLS_VER="100.9.4"
if ! command -v mongorestore >/dev/null 2>&1; then
  wget -q "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-${TOOLS_VER}.tgz"
  tar -xzf "mongodb-database-tools-ubuntu2204-x86_64-${TOOLS_VER}.tgz"
  sudo mv "mongodb-database-tools-ubuntu2204-x86_64-${TOOLS_VER}/bin"/* /usr/local/bin/
fi
mongorestore --version
