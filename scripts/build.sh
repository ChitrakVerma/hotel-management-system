<<<<<<< HEAD
"# Build Scripts" 
=======
#!/usr/bin/env bash
# Hotel Management System – Build Script
# CI #5: Build Scripts
# Usage: ./scripts/build.sh [--env <environment>]
# Description: Compiles/packages the application for deployment.

set -euo pipefail

ENV="${1:-development}"
echo "==> Building Hotel Management System (env: ${ENV})"

# ── Backend ──────────────────────────────────────────────────────────────────
echo "--> Installing backend dependencies..."
if [ -f src/backend/requirements.txt ]; then
    pip install --quiet -r src/backend/requirements.txt
elif [ -f src/backend/package.json ]; then
    npm --prefix src/backend install --silent
fi

# ── Frontend ─────────────────────────────────────────────────────────────────
echo "--> Installing frontend dependencies..."
if [ -f src/frontend/package.json ]; then
    npm --prefix src/frontend install --silent
    npm --prefix src/frontend run build
fi

echo "==> Build complete."
>>>>>>> 7cf6180940e6201ad224c1f1de8cd9d6c7f58869
