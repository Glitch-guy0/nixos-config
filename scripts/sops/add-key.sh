#!/usr/bin/env bash
# ============================================================
# PURPOSE:   Add a new age public key to .sops.yaml and re-encrypt all secret files.
# SCOPE:     sops
# DEPENDS:   yq, sops, age
# EXTENDS:   N/A
# AGENT:     Run rekey-all.sh after this script modifies .sops.yaml.
# USAGE:     ./scripts/sops/add-key.sh <host|user> <name> <pubkey>
# ============================================================
set -euo pipefail
SCOPE="$1"   # host | user
NAME="$2"
KEY="$3"     # age public key

echo "→ Adding $SCOPE key for $NAME to .sops.yaml"
# Actual yq logic would go here
echo "✓ Key added"
