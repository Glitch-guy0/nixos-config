#!/usr/bin/env bash
# ============================================================
# PURPOSE:   Re-encrypt every secret file with current .sops.yaml rules.
#            Run this after ANY change to .sops.yaml.
# ============================================================
set -euo pipefail
find secrets/ -name "*.yaml" -not -path "secrets/.sops.yaml" | while read -r f; do
  echo "→ rekeying $f (stubbed)"
  # sops updatekeys --yes "$f"
done
echo "✓ All secrets rekeyed (stubbed)"
