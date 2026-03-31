# Data Model: User Configuration Cleanup

## Overview

This document describes the data model for the user configuration cleanup feature. The model is already defined by the existing flake architecture - this document captures the entities involved.

## Entities

### User Configuration

| Field | Type | Description |
|-------|------|-------------|
| `username` | string | Unique identifier for the user |
| `homeDirectory` | string | Path to user's home directory |
| `initialPassword` | string | Initial password (may be empty for locked account) |
| `packages` | list | List of packages to install for user |

**Location**: `users/<username>/default.nix`

### Host Configuration

| Field | Type | Description |
|-------|------|-------------|
| `hostname` | string | Machine identifier |
| `defaultUsers` | list of string | Users to create on this host |
| `display.server` | string | Desktop environment |
| `audio.backend` | string | Audio backend |
| `power.profile` | string | Power profile |
| `hardware.gpu` | string | GPU driver |

**Location**: `hosts/<hostname>/config.nix`

## Relationships

```
flake.nix
  ├── hosts/ (imported via hosts/default.nix)
  │   └── <hostname>/config.nix (defines defaultUsers)
  └── users/ (imported via users/default.nix)
      └── <username>/default.nix (user configuration)
```

- A **host** references multiple **users** via `defaultUsers` list
- A **user** has one **configuration** (users/<username>/default.nix)
- Users are dynamically discovered - no manual wiring needed

## State Transitions

| State | Transition | Trigger |
|-------|-------------|---------|
| User exists in users/ | Added to defaultUsers | User created and assigned to host |
| User exists in users/ | Removed from defaultUsers | User unassigned from host |
| User removed from users/ | Referenced in defaultUsers | Build failure (orphaned reference) |

## Validation Rules

1. Every user in `defaultUsers` MUST have a corresponding directory in `users/<username>/`
2. User configuration files MUST be valid Nix expressions
3. Host configuration MUST evaluate without errors after cleanup

## Cleanup Scope

| Action | Location | Target |
|--------|----------|--------|
| Update defaultUsers | hosts/unknown/config.nix | ["alice", "bob"] → ["glitch"] |
| Update doc examples | docs/end-user/users.md | alice/bob → glitch |
| Preserve historical | specs/ | No changes |

## Notes

- The cleanup task does not introduce new entities - it removes orphaned references
- Path convention: all file paths are relative to project root
- Historical records (specs/, CHANGELOG.md) are preserved as-is
