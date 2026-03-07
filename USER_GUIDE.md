# Unknown NixOS User Guide

Welcome to the **Unknown OS** user guide! This manual is designed for end-users who want to install, configure, navigate, and maintain this NixOS system. It will walk you through setting up a new machine, understanding the folder structure, switching your desktop profiles, and handling encrypted secrets safely.

> **Important Rule:** All commands must be executed in the **project-root** of this repository.

*(Note: If you are an automated agent, maintainer, or developer looking to extend the codebase, please refer to [CONSTITUTION.md](./CONSTITUTION.md) and the `docs/` folder instead.)*

---

## 📑 Table of Contents
1. [Prerequisites](#1-prerequisites)
2. [Folder Structure & Architecture](#2-folder-structure--architecture)
   - [Overview](#overview)
   - [The `flake.nix` Exception](#the-flakenix-exception)
   - [How Files and Profiles Merge](#how-files-and-profiles-merge)
3. [Initial Setup & Installation Guide](#3-initial-setup--installation-guide)
   - [Cloning the Repository](#cloning-the-repository)
   - [Setting Up a New Host (If not Unknown)](#setting-up-a-new-host-if-not-unknown)
   - [Generating Age Keys for Secrets](#generating-age-keys-for-secrets)
   - [Installing NixOS](#installing-nixos)
4. [Host-Related Guide](#4-host-related-guide)
   - [System Updates & Rebuilding](#system-updates--rebuilding)
5. [Home-Manager & Profiles Guide](#5-home-manager--profiles-guide)
   - [Understanding Profiles (`base`, `minimal`, `server`, etc.)](#understanding-profiles-base-minimal-server-etc)
   - [Switching User Profiles](#switching-user-profiles)
6. [Managing Secrets](#6-managing-secrets)
7. [Scripts Guide](#7-scripts-guide)
   - [Available Scripts](#available-scripts)
8. [Getting Help](#8-getting-help)
9. [Disk Partitioning with Disko](#9-disk-partitioning-with-disko)
   - [What is Disko?](#what-is-disko)
   - [Why Use Disko?](#why-use-disko)
   - [Disko Configuration Location](#disko-configuration-location)
   - [Example Disko Configuration](#example-disko-configuration)
   - [How to Use Disko](#how-to-use-disko)
   - [Migrating from Manual Partitioning to Disko](#migrating-from-manual-partitioning-to-disko)

---

## 1. Prerequisites

Before starting, you must have:
- A machine booted into a [NixOS Live USB](https://nixos.org/download) or an existing NixOS installation.
- An active internet connection.
- Flakes enabled on your current system (standard on newer NixOS installs, or can be passed via command line flags).
- Disko installed on the live system (if partitioning from a standard NixOS Live USB):
  ```bash
  nix-env -iA nixos.disko
  ```

---

## 2. Folder Structure & Architecture

To make navigating the system easy, this configuration follows a strictly organized structure where system logic and user logic are strictly separated.

### Overview

- `hosts/`: Contains system-level configuration:
  - `hardware-configuration.nix`: Auto-generated hardware scan results
  - `disko.nix`: Declarative disk partitioning (NEW)
  - `disko.sh`: Script to run disko for the host (NEW)
  - `default.nix`: Host entry point
  - `boot.nix`: Bootloader configuration
  - etc.
- `users/`: Contains configurations for individual human users. Each user has their own directory with specific settings, secrets, and configurations.
- `profiles/`: Contains reusable "capability bundles" (e.g., a gaming setup, a developer setup, a minimal server setup). These bundles are meant to be imported by users to quickly gain capabilities.
- `modules/`: Contains reusable generic options and implementations. Split into `system` (NixOS) and `home` (Home Manager).
- `pkgs/`: Custom packages and overlays.
- `secrets/`: Encrypted secrets managed by `sops-nix` using Age keys.
- `scripts/`: Useful automation scripts for daily usage, adding hosts, adding users, and managing secrets.

### The `flake.nix` Exception

The entry point for everything in this repository is `flake.nix` located in the project root. While the `flake.nix` file itself may seem a bit bloated with various inputs (nixpkgs, home-manager, sops-nix, etc.), **it is intentionally centralized**.
- **Why?** It acts as the single source of truth for dependencies.
- **What is it doing?** It wires up all inputs and passes them down to the custom functions located in `lib/`. It automatically auto-detects hosts (from `hosts/`) and users/profiles (from `users/`) so you do not need to manually edit `flake.nix` every time you add a new machine or user. This design keeps the rest of the file structure extremely modular.

### How Files and Profiles Merge

When you build a system or switch a profile, Nix merges several files together:

1. **Host Merge (System level):** The host configurations found in `hosts/<hostname>/default.nix` and `hardware-configuration.nix` combine with generic `modules/system` to form your final NixOS build.
2. **User/Profile Merge (Home Manager level):** When switching users, Nix looks at `users/<username>/default.nix`. From there, you import a specific profile from `profiles/`. Nix merges the generic capabilities in the chosen profile (like `profiles/developer.nix`) with any specific tweaks the user has defined in their user directory. This ensures a clean separation of concerns and high reusability.

---

## 3. Initial Setup & Installation Guide

### Cloning the Repository
First, clone this configuration to your machine. Always navigate into this directory before running commands!
```bash
git clone https://github.com/your-username/nixos-config.git
cd nixos-config
```

### Setting Up a New Host (If not Unknown)
This repository ships with a pre-configured host named `unknown` (HP Pavilion 14-dv0054tu). If you are installing this on different hardware, you must create a new hardware profile:
```bash
# Generate your machine's unique hardware config
nixos-generate-config --show-hardware-config > hosts/your-hostname/hardware-configuration.nix
```
*You will also need to create a `default.nix` in that folder to select your desktop environment, audio backend, etc. Refer to `hosts/unknown` for an example. If using Disko, create your `disko.nix` and `disko.sh` locally in `hosts/your-hostname/`.*

### Generating Age Keys for Secrets
This setup uses `age` (via `sops-nix`) to encrypt secrets securely. Every machine needs an identity.

To generate a key for a new host:
```bash
./scripts/hosts/gen-age-key.sh your-hostname
```
*Take note of the public key output. Add it to `secrets/.sops.yaml` to grant the machine access to its encrypted files.*

### Installing NixOS

**Option 1: Using Disko (Recommended for New Installs)**
```bash
# First, run disko to partition/format disks (destroys existing data!)
sudo ./hosts/your-hostname/disko.sh destroy,format,mount

# Then install NixOS
sudo nixos-install --flake .#your-hostname
```

**Option 2: Manual Partitioning (Legacy Method)**
If you prefer to partition manually, format and mount your disks, then run:
```bash
sudo nixos-install --flake .#your-hostname
```

---

## 4. Host-Related Guide

### System Updates & Rebuilding
System-level changes live in the `hosts/` directory. When you modify these (e.g., adding a system-wide service or changing the kernel), you must rebuild the system as root.

**Important:** Run these commands from the project root!

```bash
# Apply changes and switch to them immediately
sudo nixos-rebuild switch --flake .#unknown

# Test build without switching (useful to check for syntax errors)
sudo nixos-rebuild build --flake .#unknown
```

---

## 5. Home-Manager & Profiles Guide

User applications and shell environments are strictly managed via **Home Manager profiles**. This allows you to define distinct environments (e.g., a heavy desktop setup vs. a minimal server setup) for the same user without cluttering the system.

### Understanding Profiles (`base`, `minimal`, `server`, etc.)

Profiles (located in the `profiles/` directory) are capability bundles. Here is how they differ and why they exist:

- **`base` (`profiles/base.nix`):** The foundational layer for regular users. It provides essential tools like `bash`, `git`, `curl`, and `wget`. Almost all standard profiles build on top of this.
- **`minimal` (`profiles/minimal.nix`):** A bare-bones survival kit. It includes only absolute necessities like `vim` and `wget`. It does *not* include the extras from `base`, making it ideal for recovery or ultra-constrained environments.
- **`server` (`profiles/server.nix`):** Designed for headless, hardened environments. It imports `base.nix` but typically lacks any graphical environment or heavy desktop applications.
- **`developer` (`profiles/developer.nix`):** Builds on top of `base` but includes compilers, IDEs, and developer-specific tooling.
- **`gaming` (`profiles/gaming.nix`):** Builds on top of `base` with game-specific optimizations, launchers, and drivers.
- **`designer` (`profiles/designer.nix`):** Builds on top of `base` and includes graphical design and video editing software.

Because of this structure, an end user can use a `gaming` profile on their personal desktop, and use a `server` profile on their VPS, all managed from this single repository.

### Switching User Profiles
To switch your profile (no root required), use the format `user@profile` from the **project root**:

```bash
# Switch to Glitch's developer profile
home-manager switch --flake .#glitch@developer

# Switch to Glitch's minimal profile
home-manager switch --flake .#glitch@minimal
```

*Tip for Testing:* If you want to test a profile quickly without touching the system registry, you can use the standalone intermediate flake:
```bash
home-manager switch --flake ./users#glitch@developer
```

---

## 6. Managing Secrets

Secrets are never stored in plain text. They are securely encrypted in the `secrets/` directory.

To manage them, use the scripts in `scripts/sops/`:
1. **Adding a key:** If you add a new machine or user, generate their age key, place the public key in `secrets/.sops.yaml`, and run:
   ```bash
   ./scripts/sops/add-key.sh <scope> <name> <pubkey>
   ```
2. **Re-encrypting:** If you change access rules in `.sops.yaml` (like granting a new admin access to all secrets), you must re-encrypt the files:
   ```bash
   ./scripts/sops/rekey-all.sh
   ```

---

## 7. Scripts Guide

This repository includes several automation scripts in the `scripts/` folder to make common tasks easier. All scripts include inline documentation explaining their usage and purpose.

**Rule of Thumb:** Always run these scripts from the repository root.

### Available Scripts

- **`scripts/check.sh`**: Runs linting, formatting (`nixfmt`), and validation (`statix`, `deadnix`) across the entire repository. Run this before committing any changes!
- **`scripts/hosts/gen-age-key.sh <hostname>`**: Generates a new `age` keypair for a host, returning the public key and storing the private key properly.
- **`scripts/sops/add-key.sh <scope> <name> <pubkey>`**: Automates adding a new age public key to the secrets manager.
- **`scripts/sops/rekey-all.sh`**: Re-encrypts all secrets based on the current `.sops.yaml` configuration. Required whenever a key is added or removed.

*Tip: For more details, you can read the scripts directly. They all contain `USAGE` inline documentation at the top of the file.*

---

## 8. Getting Help

- **End-Users:** If you run into issues switching profiles or rebuilding, double-check your syntax in the `.nix` files you edited, and ensure your age keys are properly configured in `secrets/.sops.yaml`.
- **Developers & Agents:** If you are looking to add a new reusable module, create a new capability bundle, or refactor the repository structure, read the [CONSTITUTION.md](./CONSTITUTION.md) and the technical guides located in the `docs/` folder.

---

## 9. Disk Partitioning with Disko

This system uses **disko** for declarative disk partitioning. This ensures your disk layout is version-controlled and reproducible.

### What is Disko?
Disko is a NixOS utility that allows you to define your disk partitioning, formatting, and mounting in Nix code rather than using manual commands like `fdisk` or `parted`.

### Why Use Disko?
- **Reproducible**: Disk layouts are stored in version control
- **Idempotent**: Running disko again won't change existing partitions if they match the config
- **Documentation**: Your config serves as documentation of your disk layout
- **Automation**: No manual partitioning needed during installs

### Disko Configuration Location
Disko configurations are stored per host in:
`hosts/<hostname>/disko.nix`

The helper script to run disko operations is located at:
`hosts/<hostname>/disko.sh`

### Example Disko Configuration (for `unknown`)
```nix
# hosts/unknown/disko.nix
{
  # ============================================================
  # PURPOSE:   Declarative disk partitioning for host 'unknown'.
  # SCOPE:     host
  # ============================================================
  disks ? [ "/dev/nvme0n1" ], ...
}: {
  disko.devices = {
    disk = {
      main = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              size = "1G";
              type = "EF00"; # EFI System Partition
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "fmask=0022" "dmask=0022" ];
              };
            };
            swap = {
              size = "8G";
              type = "8200"; # Linux Swap
              content = {
                type = "swap";
              };
            };
            root = {
              size = "100%";
              type = "8300"; # Linux Filesystem
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

### How to Use Disko

1. **Add Disko to Your Host Configuration**
Add it to `hosts/<hostname>/default.nix`:
```nix
{ pkgs, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix  # Add this line
    # ... other imports
  ];
  # ... existing config
}
```

2. **Run Disko During Install**
When installing NixOS, use your host's disko script to partition your disks:
```bash
# First, run disko to partition/format disks (destroys existing data!)
sudo ./hosts/<hostname>/disko.sh destroy,format,mount

# Then install NixOS
sudo nixos-install --flake .#<hostname>
```

3. **Generating Hardware Configuration from Disko**
You can generate a `hardware-configuration.nix` from your disko config:
```bash
./hosts/<hostname>/disko.sh mount
nixos-generate-config --root /mnt --show-hardware-config
```

**Important Notes:**
- **Danger**: The destroy mode will erase all data on your disks!
- **Always test**: You can use dry-run mode or review operations before executing.
- **Keep config updated**: If you change your disk layout, update the disko config first.

**Troubleshooting:**
- If disko fails to mount, check that your disk labels or UUIDs match.
- For encrypted disks, see the disko examples on GitHub.
- If you get "device not found" errors, verify your disk path (e.g., `/dev/nvme0n1` vs `/dev/sda`).

### Migrating from Manual Partitioning to Disko

If you have an existing installation with manual partitions, you can migrate to disko:
1. **Create your disko config**: Create `disko.nix` in your host's directory based on the example.
2. **Match existing partitions**: Update the disko config to perfectly match your current disk layout.
3. **Create the runner script**: Ensure you have `disko.sh` locally for the host to easily trigger commands.
4. **Test disko mount**: Run `sudo ./hosts/<hostname>/disko.sh mount` to verify it can mount your existing partitions without destroying data.
5. **Update hardware-configuration.nix**: Generate a new hardware config using disko if required.
6. **Rebuild system**: Test the new config with `nixos-rebuild test --flake .#<hostname>` before switching.

**Important**: Always back up your data before making any disk-related changes!
