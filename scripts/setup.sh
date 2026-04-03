#!/usr/bin/env bash
# Hotel Management System – Environment Setup Script
# CI #5: Build Scripts
# Usage: ./scripts/setup.sh
# Description: Sets up the local development environment from scratch.

set -euo pipefail

echo "==> Setting up Hotel Management System development environment"

# ── Python virtual environment (backend) ────────────────────────────────────
if command -v python3 &>/dev/null; then
    echo "--> Creating Python virtual environment..."
    python3 -m venv .venv
    # shellcheck source=/dev/null
    source .venv/bin/activate
    if [ -f src/backend/requirements.txt ]; then
        pip install --quiet -r src/backend/requirements.txt
    fi
fi

# ── Node.js dependencies (frontend) ─────────────────────────────────────────
if command -v npm &>/dev/null && [ -f src/frontend/package.json ]; then
    echo "--> Installing frontend Node.js dependencies..."
    npm --prefix src/frontend install --silent
fi

# ── Environment file ─────────────────────────────────────────────────────────
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        cp .env.example .env
        echo "--> Created .env from .env.example – please edit with your credentials."
    fi
fi

# ── Database setup ───────────────────────────────────────────────────────────
echo "--> Initialising database schema..."
if command -v psql &>/dev/null && [ -n "${DATABASE_URL:-}" ]; then
    psql "${DATABASE_URL}" -f database/schema.sql
else
    echo "WARNING: psql not found or DATABASE_URL not set – skipping DB setup."
    echo "         Run: psql <connection-string> -f database/schema.sql manually."
fi

echo "==> Setup complete. Run './scripts/build.sh' to build the project."
