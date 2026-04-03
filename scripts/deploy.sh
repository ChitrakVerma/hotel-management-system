#!/usr/bin/env bash
# Hotel Management System – Deployment Script
# CI #5: Build Scripts
# Usage: ./scripts/deploy.sh [--env <production|staging>]
# Description: Deploys the built application to the target environment.

set -euo pipefail

ENV="${1:-staging}"
echo "==> Deploying Hotel Management System to ${ENV}"

# ── Pre-flight checks ────────────────────────────────────────────────────────
echo "--> Running pre-deployment checks..."
if [ ! -f ".env.${ENV}" ] && [ ! -f ".env" ]; then
    echo "WARNING: No .env file found for environment '${ENV}'."
fi

# ── Database migrations ──────────────────────────────────────────────────────
echo "--> Applying database schema..."
if command -v psql &>/dev/null; then
    psql "${DATABASE_URL:-}" -f database/schema.sql
else
    echo "WARNING: psql not found – skipping database migration."
fi

# ── Restart services ─────────────────────────────────────────────────────────
echo "--> Restarting application services..."
if command -v systemctl &>/dev/null; then
    systemctl restart hotel-management-backend || true
    systemctl restart hotel-management-frontend || true
fi

echo "==> Deployment to ${ENV} complete."
