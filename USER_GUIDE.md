# Unknown NixOS User Guide

Welcome to the **Unknown OS** user guide! This manual is designed for end-users who want to install, configure, and maintain this NixOS system. It will walk you through setting up a new machine, switching your desktop profiles, and handling encrypted secrets safely.

*(Note: If you are an automated agent, maintainer, or developer looking to extend the codebase, please refer to [CONSTITUTION.md](./CONSTITUTION.md) and the `docs/` folder instead.)*

---

## 📑 Table of Contents
1. [Prerequisites](#1-prerequisites)
2. [Initial Setup & Installation](#2-initial-setup--installation)
   - [Cloning the Repository](#cloning-the-repository)
   - [Setting Up a New Host (If not Unknown)](#setting-up-a-new-host-if-not-unknown)
   - [Generating Age Keys for Secrets](#generating-age-keys-for-secrets)
   - [Installing NixOS](#installing-nixos)
3. [Day-to-Day Usage](#3-day-to-day-usage)
   - [System Updates & Rebuilding](#system-updates--rebuilding)
   - [Switching User Profiles (Home Manager)](#switching-user-profiles-home-manager)
4. [Managing Secrets](#4-managing-secrets)
5. [Getting Help](#5-getting-help)

---

## 1. Prerequisites

Before starting, you must have:
- A machine booted into a [NixOS Live USB](https://nixos.org/download) or an existing NixOS installation.
- An active internet connection.
- Flakes enabled on your current system (standard on newer NixOS installs, or can be passed via command line flags).

## 2. Initial Setup & Installation

### Cloning the Repository
First, clone this configuration to your machine (usually under `~/.nixos-config` or `/etc/nixos` if replacing the default):
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
*You will also need to create a `config.nix` in that folder to select your desktop environment, audio backend, etc.*

### Generating Age Keys for Secrets
This setup uses `age` (via `sops-nix`) to encrypt secrets (like VPN keys, passwords, and API tokens). Every machine and user needs an identity.

To generate a key for a new host:
```bash
./scripts/hosts/gen-age-key.sh your-hostname
```
*Take note of the public key output. You will need to add it to `secrets/.sops.yaml` to grant the machine access to its encrypted files.*

### Installing NixOS
If you are installing onto formatted disks (e.g., mounted at `/mnt`), deploy the flake:
```bash
sudo nixos-install --flake .#unknown
```
*(Replace `unknown` with your new hostname if applicable.)*

---

## 3. Day-to-Day Usage

### System Updates & Rebuilding
When you modify system-level configurations (e.g., changing the desktop environment in `hosts/unknown/config.nix`), you must rebuild the system as root:

```bash
# Apply changes and switch to them immediately
sudo nixos-rebuild switch --flake .#unknown

# Test build without switching (useful to check for syntax errors)
sudo nixos-rebuild build --flake .#unknown
```

### Switching User Profiles (Home Manager)
User applications and shell environments are managed via **Home Manager profiles**. This allows you to have a `work` profile with developer tools and a `personal` profile for gaming or browsing.

To switch your profile (no root required), use the format `user@profile`:
```bash
# Switch to Glitch's work profile
home-manager switch --flake .#glitch@work

# Switch to Glitch's personal profile
home-manager switch --flake .#glitch@personal
```

*Tip for Testing:* If you want to test a profile quickly without touching the system registry, you can use the standalone intermediate flake:
```bash
home-manager switch --flake ./users#glitch@dev
```

---

## 4. Managing Secrets

Secrets are never stored in plain text. They are securely encrypted in the `secrets/` directory.

To manage them, you use the provided scripts in `scripts/sops/`:
1. **Adding a key:** If you add a new machine or user, generate their age key, place the public key in `secrets/.sops.yaml`, and run:
   ```bash
   ./scripts/sops/add-key.sh <scope> <name> <pubkey>
   ```
2. **Re-encrypting:** If you change access rules (like granting a new admin access to all secrets), you must re-encrypt the files so the new keys can read them:
   ```bash
   ./scripts/sops/rekey-all.sh
   ```

---

## 5. Getting Help

- **End-Users:** If you run into issues switching profiles or rebuilding, double-check your syntax in the `.nix` files you edited, and ensure your age keys are properly configured in `secrets/.sops.yaml`.
- **Developers & Agents:** If you are looking to add a new reusable module, create a new capability bundle, or refactor the repository structure, read the [CONSTITUTION.md](./CONSTITUTION.md) and the technical guides located in the `docs/` folder.
