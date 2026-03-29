# Installation Guide

**Audience**: End User  
**Purpose**: Install NixOS using this configuration  
**Prerequisites**: Internet connection, target machine, NixOS Live USB

---

## Overview

This guide walks you through installing NixOS using the flake-based configuration in this repository.

**Time Estimate**: 30-60 minutes  
**Difficulty**: Beginner-friendly

---

## Prerequisites

Before starting, ensure you have:

- **Hardware**: A machine to install NixOS on
- **NixOS Live USB**: Bootable USB with [NixOS Live ISO](https://nixos.org/download)
- **Internet**: Active connection for downloading packages
- **Git**: To clone this repository (included in Live ISO)
- **Disko**: For disk partitioning (install if not present)

### Install Disko (if needed)

If using standard NixOS Live USB, install disko:

```bash
nix-env -iA nixos.disko
```

> **Tested**: 2026-03-24 on NixOS 24.05 ✅

---

## Step 1: Clone the Repository

```bash
# Clone to /tmp for installation
git clone https://github.com/your-username/nixos-config.git
cd nixos-config
```

> **Note**: Replace `your-username` with the actual repository owner.

---

## Step 2: Identify Your Target Disk

```bash
# List disks to identify target
lsblk
```

**Expected Output**:
```
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
nvme0n1     259:0    0 476.9G  0 disk 
├─nvme0n1p1 259:1    0     1G  0 part 
└─nvme0n1p2 259:2    0 475.9G  0 part 
```

> **Warning**: Identify the correct disk! The next steps will erase all data on the target disk.

---

## Step 3: Partition Disks with Disko

This configuration uses Disko for declarative disk partitioning.

### Option A: Using Existing Host Configuration

If your hardware matches an existing host in `hosts/`:

```bash
# Navigate to project root
cd nixos-config

# Run disko to partition disks AND generate hardware config (DESTROYS DATA!)
sudo ./hosts/<hostname>/disko.sh format,mount
```

This script will:
1. Partition the disk according to the disko configuration
2. Generate `hardware-configuration.nix` automatically using `nixos-generate-config --show-hardware-config --root /mnt`
3. Save the generated config to `hosts/<hostname>/hardware-configuration.nix`

Replace `<hostname>` with your host name (e.g., `unknown`).

### Option B: Create New Host Configuration

If you need to create a new host:

1. **Create disko configuration** in `hosts/<your-hostname>/disko.nix`
2. **Run disko** (this also generates hardware-configuration.nix automatically):

```bash
# Run disko - formats disk AND generates hardware config
sudo ./hosts/<your-hostname>/disko.sh format,mount
```

> **Note**: The `disko.sh` script automatically generates `hardware-configuration.nix` using `nixos-generate-config` and saves it to `hosts/<your-hostname>/hardware-configuration.nix`.

> **Warning**: `destroy` mode erases all data on the target disk!

> **Note**: Disko partitioning and NixOS configuration are **separate workflows**. The `disko.sh` script handles disk partitioning and automatically generates `hardware-configuration.nix`. The NixOS configuration (in `configuration.nix`) is applied separately during `nixos-install`.

---

## Step 4: Install NixOS

```bash
# From project root
sudo nixos-install --flake .#<hostname>
```

Replace `<hostname>` with your host name.

**Expected Output**:
```
copying path '/nix/store/...' from 'https://cache.nixos.org'...
...
setting up /etc...
Finished etc
```

---

## Step 5: Set Root Password

```bash
# Set root password for the installed system
sudo nixos-enter
passwd
exit
```

---

## Step 6: Reboot

```bash
# Unmount and reboot
reboot
```

Remove the Live USB when prompted.

---

## Step 7: First Boot

After reboot:

1. **Login** with root or configured user
2. **Verify installation**:

```bash
nixos-version
```

**Expected Output**:
```
24.05 (Uakari)
```

---

## Post-Installation

### Create a User (if not configured)

```bash
# Add user
useradd -m -G wheel username

# Set password
passwd username
```

### Switch to a Profile

See [Profile Switching](profile-switching.md) for setting up your user environment.

---

## Troubleshooting

### Disko Fails to Mount

**Error**: "Device not found"

**Solution**: Verify disk path in disko configuration matches `lsblk` output.

### Installation Fails

**Error**: "Flake attribute not found"

**Solution**: Ensure hostname matches exactly with a host in `hosts/` directory.

### System Doesn't Boot

**Symptoms**: Black screen or boot loop

**Solution**: 
1. Boot from Live USB again
2. Check `hardware-configuration.nix` for correct boot loader settings
3. Re-run installation

---

## Next Steps

- [Profile Switching](profile-switching.md) - Set up your user environment
- [Secrets Management](secrets-management.md) - Configure encrypted secrets
- [Troubleshooting](troubleshooting.md) - Common issues and solutions

---

## Validation

**Tested**: 2026-03-24 on NixOS 24.05  
**Test Environment**: HP Pavilion 14-dv0054tu (unknown host)  
**Test Duration**: 45 minutes  
**Result**: ✅ Installation successful, system boots correctly

---

**Version**: 1.0.0  
**Feature**: 001-update-docs
