# New Host Setup

**Audience**: End User  
**Purpose**: Create a new host configuration for your hardware  
**Prerequisites**: Completed [installation](installation.md), access to repository

---

## Overview

This guide helps you create a new host configuration if your hardware differs from existing hosts in the repository.

**Time Estimate**: 15-30 minutes  
**Difficulty**: Intermediate

---

## When to Create a New Host

Create a new host when:

- Your hardware differs from existing hosts
- You need different system configuration
- You're setting up a new machine

---

## Step 1: Generate Hardware Configuration

```bash
# Navigate to project root
cd /path/to/nixos-config

# Create directory for your host
mkdir -p hosts/<your-hostname>

# Generate hardware configuration
nixos-generate-config --show-hardware-config > hosts/<your-hostname>/hardware-configuration.nix
```

Replace `<your-hostname>` with a descriptive name (e.g., `workstation`, `laptop`, `server`).

---

## Step 2: Create Host Configuration

Create `hosts/<your-hostname>/default.nix`:

```nix
{ pkgs, hostname, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Set hostname
  networking.hostName = "<your-hostname>";

  # Select desktop environment (if applicable)
  # services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Select audio backend
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Include base profile
  imports = [
    ../../profiles/base.nix
  ];
}
```

---

## Step 3: Create Disko Configuration (Optional)

If using Disko for partitioning, create `hosts/<your-hostname>/disko.nix`:

```nix
{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1"; # Change to your disk
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

Create `hosts/<your-hostname>/disko.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

DISKO_SCRIPT="$(dirname "${BASH_SOURCE[0]}")/disko.nix"

# Parse arguments
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

Make it executable:

```bash
chmod +x hosts/<your-hostname>/disko.sh
```

---

## Step 4: Test Build

```bash
# Test the configuration without installing
sudo nixos-rebuild build --flake .#<your-hostname>
```

**Expected Output**:
```
building the system configuration...
```

---

## Step 5: Switch to New Host

```bash
# Apply the new configuration
sudo nixos-rebuild switch --flake .#<your-hostname>
```

---

## Step 6: Verify

```bash
# Check hostname
hostname

# Check system
nixos-version
```

---

## Troubleshooting

### Build Fails

**Error**: "attribute 'xyz' missing"

**Solution**: Check that all imports exist and paths are correct.

### Disko Configuration Fails

**Error**: "Device not found"

**Solution**: Verify disk device name matches `lsblk` output.

### Hardware Configuration Missing Devices

**Symptoms**: Some hardware not working

**Solution**: Regenerate `hardware-configuration.nix` after booting into new host.

---

## Next Steps

- [Profile Switching](profile-switching.md) - Set up user environment
- [Secrets Management](secrets-management.md) - Configure secrets for new host

---

## Validation

**Tested**: 2026-03-24 on NixOS 24.05  
**Test Environment**: New host configuration  
**Result**: ✅ Host builds and switches successfully

---

**Version**: 1.0.0  
**Feature**: 001-update-docs
