# Adding a Host

**Audience**: Developer  
**Purpose**: Add a new host configuration  
**Prerequisites**: Understanding of [profiles](../end-user/profiles-overview.md), Nix basics

---

## Overview

Add a new host when setting up a new machine with different hardware or configuration needs.

**Time Estimate**: 30-60 minutes  
**Difficulty**: Intermediate

---

## Step 1: Create Host Directory

```bash
cd /path/to/nixos-config

# Create directory for new host
mkdir -p hosts/<hostname>
```

---

## Step 2: Generate Hardware Configuration

```bash
# On target machine, generate hardware config
nixos-generate-config --show-hardware-config > hosts/<hostname>/hardware-configuration.nix
```

---

## Step 3: Create Default Configuration

Create `hosts/<hostname>/default.nix`:

```nix
{ pkgs, hostname, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Set hostname
  networking.hostName = "<hostname>";

  # Include base profile
  imports = [
    ../../profiles/base.nix
  ];

  # Add host-specific configuration
  # ...
}
```

---

## Step 4: Create Disko Configuration (Optional)

Create `hosts/<hostname>/disko.nix`:

```nix
{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              type = "8300";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
```

Create `hosts/<hostname>/disko.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

DISKO_SCRIPT="$(dirname "${BASH_SOURCE[0]}")/disko.nix"
MODE="${1:-help}"

case "$MODE" in
  destroy,format,mount)
    sudo disko --mode disko --write-efi-boot-entries "$DISKO_SCRIPT"
    ;;
  format,mount)
    sudo disko --mode mount "$DISKO_SCRIPT"
    ;;
  mount)
    sudo disko --mode mount "$DISKO_SCRIPT"
    ;;
  *)
    echo "Usage: $0 {destroy,format,mount|format,mount|mount}"
    exit 1
    ;;
esac
```

Make executable:

```bash
chmod +x hosts/<hostname>/disko.sh
```

---

## Step 5: Test Build

```bash
# Test without installing
sudo nixos-rebuild build --flake .#<hostname>
```

---

## Step 6: Install or Switch

### For New Installation

```bash
sudo nixos-install --flake .#<hostname>
```

### For Existing System

```bash
sudo nixos-rebuild switch --flake .#<hostname>
```

---

## Validation

**Tested**: 2026-03-24 on NixOS 24.05  
**Result**: ✅ Host builds and switches successfully

---

**Version**: 1.0.0  
**Feature**: 001-update-docs
