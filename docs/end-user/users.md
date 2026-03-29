# User Configuration

**Date**: 2026-03-29
**Feature**: Host User Configuration (001-host-user-config)

## Overview

This document describes the user configuration system in this NixOS configuration. Users are defined in shared configuration files and referenced from host configurations.

## Quick Start

### 1. Create User Configuration

Create `users/<username>/default.nix`:

```nix
{ pkgs, ... }:
{
  initialPassword = "TempPass123!";
  extraGroups = [ "wheel" "docker" ];
}
```

### 2. Add User to Host

In `hosts/<hostname>/config.nix`:

```nix
{
  defaultUsers = [ "alice" "bob" ];
}
```

### 3. Build and Activate

```bash
nixos-rebuild switch --flake .#hostname
```

## Host Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `defaultUsers` | `listOf str` | `[]` | List of usernames to create on this host |

### Examples

```nix
# No additional users
defaultUsers = [];

# Single user
defaultUsers = [ "alice" ];

# Multiple users
defaultUsers = [ "alice" "bob" "charlie" ];
```

## User Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `initialPassword` | `str` | `""` | Initial password (empty = locked account) |
| `extraGroups` | `listOf str` | `[]` | Additional groups to add user to |

### Examples

```nix
# User with password
{
  initialPassword = "SecureTemp123!";
}

# User without password (locked, SSH key only)
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

### Shared User Across Multiple Hosts

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

### Host-Specific Users

```nix
# hosts/server/config.nix
defaultUsers = [ "admin" "deploy" ];

# hosts/workstation/config.nix
defaultUsers = [ "alice" ];
```

## Troubleshooting

### User Not Created

**Check**:
1. Username is in `defaultUsers` list (exact match, case-sensitive)
2. User directory exists: `users/<username>/default.nix`
3. Build completed without errors

### Password Not Working

**Check**:
1. `initialPassword` is set in user config (not empty string)
2. User is in host's `defaultUsers` list
3. Password authentication is enabled on the system

### User Removed from Host

User accounts are **preserved** when removed from `defaultUsers`. Only new system builds won't create them.

## Security Notes

- **Change passwords on first login**: Initial passwords should be temporary
- **Consider sops-nix for production**: Encrypted password storage (future iteration)
- **Password in nix store**: Plaintext passwords stored in nix store; use SSH keys for sensitive environments

## Related Documentation

- [Feature Spec](../../specs/001-host-user-config/spec.md) - Requirements and acceptance criteria
- [Data Model](../../specs/001-host-user-config/data-model.md) - Entity definitions and relationships
- [NixOS Manual](https://nixos.org/manual/nixos/stable/#ch-users) - users.groups module