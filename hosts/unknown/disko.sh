#!/usr/bin/env bash
# ============================================================
# PURPOSE:   Run disko operations for the 'unknown' host.
# SCOPE:     host
# DEPENDS:   nixos.disko, ./disko.nix
# USAGE:     ./hosts/unknown/disko.sh [format|mount|destroy]
# ============================================================
set -e

MODE="${1:-destroy,format,mount}"
HOST="unknown"
DISKO_CONFIG="./hosts/${HOST}/disko.nix"
TARGET_HW_CONFIG="./hosts/${HOST}/hardware-configuration.nix"
MNT="/mnt"

if [ ! -f "$DISKO_CONFIG" ]; then
  echo "Error: Disko config not found at $DISKO_CONFIG"
  exit 1
fi

echo "=== Running temporary shell Installing disko ==="
nix-env --install disko --yes-wipe-all-disks
echo "=== Running disko $MODE on host $HOST ==="
sudo disko -m "$MODE" "$DISKO_CONFIG"

# Generate hardware configuration and update
echo "=== Generating hardware configuration ==="
sudo nixos-generate-config --show-hardware-config --root "$MNT" > "$TARGET_HW_CONFIG"

echo "=== Done ==="
