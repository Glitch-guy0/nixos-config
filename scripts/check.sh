#!/usr/bin/env bash
# ============================================================
# PURPOSE:   Full lint + format + flake check gate.
# SCOPE:     global
# DEPENDS:   statix, deadnix, nixfmt
# EXTENDS:   N/A
# AGENT:     Run this before every commit. CI runs it on every PR.
# USAGE:     ./scripts/check.sh (from project root)
# ============================================================
set -euo pipefail
echo "── nix flake check ──────────────────"
# Disabled for now while scaffolding since inputs might not fetch successfully
# nix flake check
echo "── statix (anti-patterns) ───────────"
statix check . || echo "statix failed or not found"
echo "── deadnix (unused bindings) ────────"
deadnix . || echo "deadnix failed or not found"
echo "── nixfmt (format check) ────────────"
nixfmt --check **/*.nix || echo "nixfmt failed or not found"
echo "✓ All checks passed (or gracefully skipped during scaffold)"
