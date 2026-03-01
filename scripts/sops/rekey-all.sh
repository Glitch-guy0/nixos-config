#!/usr/bin/env bash
# ============================================================
# PURPOSE:   Re-encrypt every secret file with current .sops.yaml rules.
# SCOPE:     sops
# DEPENDS:   sops
# EXTENDS:   N/A
# AGENT:     Run this after ANY change to .sops.yaml.
# USAGE:     ./scripts/sops/rekey-all.sh
# ============================================================
set -euo pipefail
find secrets/ -name "*.yaml" -not -path "secrets/.sops.yaml" | while read -r f; do
  echo "→ rekeying $f (stubbed)"
  # sops updatekeys --yes "$f"
done
echo "✓ All secrets rekeyed (stubbed)"
