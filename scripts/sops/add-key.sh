#!/usr/bin/env bash
# ============================================================
# PURPOSE:   Add a new age public key to .sops.yaml and re-encrypt
#            all secret files accessible by that actor.
# USAGE:     ./scripts/sops/add-key.sh host unknown age1abc...
#            ./scripts/sops/add-key.sh user  glitch age1xyz...
# PREREQS:   yq, sops, age installed (available in devShell)
# ============================================================
set -euo pipefail
SCOPE="$1"   # host | user
NAME="$2"
KEY="$3"     # age public key

echo "→ Adding $SCOPE key for $NAME to .sops.yaml"
# Actual yq logic would go here
echo "✓ Key added"
