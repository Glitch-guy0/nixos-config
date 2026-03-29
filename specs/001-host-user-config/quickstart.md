# Quickstart: Host User Configuration

**Date**: 2026-03-29
**Feature**: Host User Configuration (001-host-user-config)

## Overview

This feature enables you to:
1. Declare which users should exist on a host via `defaultUsers` in host config
2. Set initial passwords for users in their user-specific config files
3. Share user definitions across multiple hosts

## Quick Start

### Step 1: Create User Configuration

Create a directory for your user under `users/`:

```bash
mkdir -p users/alice
```

Create `users/alice/default.nix`:

```nix
{ pkgs, ... }:
{
  # Initial password (change on first login!)
  initialPassword = "TempPass123!";
  
  # Optional: additional groups
  extraGroups = [ "wheel" "docker" ];
  
  # Optional: custom home directory
  homeDirectory = "/home/alice";
  
  # Optional: custom shell
  shell = pkgs.zsh;
  
  # Your existing user config (home-manager modules, packages, etc.)
  home.packages = with pkgs; [
    git
    vim
  ];
}
```

### Step 2: Add User to Host Configuration

Edit your host's `config.nix` file:

```nix
# hosts/myhost/config.nix
{ pkgs, ... }:
{
  # Add users to this host
  defaultUsers = [ "alice" "bob" ];
  
  # ... rest of your host config
}
```

### Step 3: Build and Activate

```bash
# Test the configuration
nixos-rebuild build --flake .#myhost

# Apply the configuration
sudo nixos-rebuild switch --flake .#myhost
```

### Step 4: Verify User Creation

```bash
# Check if users exist
id alice
id bob

# Test login (password: TempPass123!)
ssh alice@myhost
```

## Configuration Reference

### Host Configuration (`hosts/<hostname>/config.nix`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `defaultUsers` | `listOf str` | `[]` | Users to create on this host |

**Examples**:

```nix
# No additional users (root only)
defaultUsers = [];

# Single user
defaultUsers = [ "alice" ];

# Multiple users
defaultUsers = [ "alice" "bob" "charlie" ];

# Omitted entirely (same as empty list)
# defaultUsers not specified
```

### User Configuration (`users/<name>/default.nix`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `initialPassword` | `str` | `""` | Initial password (empty = locked) |
| `extraGroups` | `listOf str` | `[]` | Additional groups |
| `homeDirectory` | `str` | Auto | Home directory path |
| `shell` | `pkg` | Auto | Login shell package |

**Examples**:

```nix
# User with password
{
  initialPassword = "SecureTemp123!";
}

# User without password (locked account, SSH key only)
{
  initialPassword = "";
}

# User with groups
{
  initialPassword = "TempPass!";
  extraGroups = [ "wheel" "networkmanager" "docker" ];
}
```

## Common Patterns

### Pattern 1: Shared User Across Multiple Hosts

User definition lives in one place; reference from multiple hosts:

```nix
# users/alice/default.nix (single source of truth)
{
  initialPassword = "AliceTemp123!";
  extraGroups = [ "wheel" ];
}

# hosts/desktop/config.nix
defaultUsers = [ "alice" ];

# hosts/laptop/config.nix
defaultUsers = [ "alice" ];
```

### Pattern 2: Host-Specific Users

Different users on different hosts:

```nix
# hosts/server/config.nix
defaultUsers = [ "admin" "deploy" ];

# hosts/workstation/config.nix
defaultUsers = [ "alice" ];
```

### Pattern 3: Passwordless Users (SSH Key Only)

```nix
# users/deploy/default.nix
{
  # No password - SSH key authentication only
  initialPassword = "";
  
  # SSH keys would be defined elsewhere
  # (e.g., via home-manager or separate module)
}
```

## Troubleshooting

### User Not Created

**Symptom**: User doesn't exist after rebuild

**Check**:
1. Username is in `defaultUsers` list (exact match, case-sensitive)
2. User directory exists: `users/<username>/default.nix`
3. Build completed without errors

### Password Not Working

**Symptom**: Cannot login with configured password

**Check**:
1. `initialPassword` is set in user config (not empty string)
2. User is in host's `defaultUsers` list
3. Password authentication is enabled on the system

### User Removed from Host

**Symptom**: What happens when I remove a user from `defaultUsers`?

**Answer**: User account is **preserved**. Removal only prevents future creation on new systems; existing users are not deleted.

## Security Notes

- **Change passwords on first login**: Initial passwords should be temporary
- **Consider sops-nix for production**: For encrypted password storage (future iteration)
- **Password in nix store**: Plaintext passwords are stored in nix store; use SSH keys for sensitive environments

## Related Documentation

- [Data Model](./data-model.md) - Entity definitions and relationships
- [Feature Spec](./spec.md) - Requirements and acceptance criteria
- [NixOS Manual](https://nixos.org/manual/nixos/stable/#ch-users) - users.groups module
