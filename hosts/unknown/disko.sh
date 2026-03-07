#!/usr/bin/env bash
# ============================================================
# PURPOSE:   Run disko operations for the 'unknown' host.
# SCOPE:     host
# DEPENDS:   nixos.disko, ./disko.nix
# USAGE:     ./hosts/unknown/disko.sh [destroy,format,mount|mount]
# ============================================================
set -e

# Default to format,mount if no argument is provided
MODE="${1:-format,mount}"
HOST="unknown"

# The script assumes it's being run from the project root based on repository guidelines
DISKO_CONFIG="./hosts/${HOST}/disko.nix"

if [ ! -f "$DISKO_CONFIG" ]; then
  echo "Error: Disko config not found at $DISKO_CONFIG"
  exit 1
fi

echo "Running disko $MODE on host $HOST using $DISKO_CONFIG"
sudo disko -m "$MODE" "$DISKO_CONFIG"
