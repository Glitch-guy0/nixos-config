# Data Model: Host User Configuration

**Date**: 2026-03-29
**Feature**: Host User Configuration (001-host-user-config)

## Entities

### 1. Host Configuration

**Location**: `hosts/<hostname>/config.nix`

**Purpose**: Declares which users should exist on a specific host.

**Attributes**:
| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `defaultUsers` | `listOf str` | No | `[]` | List of usernames to create on this host |

**Example**:
```nix
{
  # In hosts/myhost/config.nix
  defaultUsers = [ "alice" "bob" ];
}
```

**Relationships**:
- References user definitions in `users/<username>/default.nix`
- One host can reference multiple users
- One user can be referenced by multiple hosts

---

### 2. User Configuration

**Location**: `users/<username>/default.nix`

**Purpose**: Defines user-specific attributes and settings.

**Attributes**:
| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `initialPassword` | `str` | No | `""` | Initial password (empty = locked account) |
| `extraGroups` | `listOf str` | No | `[]` | Additional groups to add user to |
| `homeDirectory` | `str` | No | Auto | User's home directory path |
| `shell` | `str` | No | Auto | User's login shell |

**Example**:
```nix
# In users/alice/default.nix
{
  initialPassword = "TempPass123!";
  extraGroups = [ "wheel" "docker" ];
  homeDirectory = "/home/alice";
  shell = pkgs.zsh;
}
```

**Relationships**:
- Independent of host configurations
- Can be referenced by zero or more hosts
- User definition lives here; host only declares presence

---

### 3. User-Host Mapping

**Purpose**: Implicit relationship created when a user is in a host's `defaultUsers` list.

**Behavior**:
- When user `alice` is in `hosts/myhost/config.nix` → `defaultUsers`
- System reads `users/alice/default.nix` for user attributes
- Applies `initialPassword`, `extraGroups`, etc. to the NixOS user definition

**State Transitions**:

```
[User not in defaultUsers]
         |
         | Add to defaultUsers list
         v
[User created on next build]
         |
         | Remove from defaultUsers list
         v
[User preserved (not deleted)]
```

---

## Validation Rules

### From Requirements

| Rule ID | Description | Enforcement |
|---------|-------------|-------------|
| FR-002 | `defaultUsers` must be array of strings | Nix type system |
| FR-003 | `defaultUsers` defaults to empty array | Module default |
| FR-005 | `initialPassword` accepts string | Nix type system |
| FR-006 | `initialPassword` defaults to unset | Module default |
| FR-009 | User creation is idempotent | NixOS declarative model |
| FR-013 | Removing user preserves account | `mutableUsers = true` |

### Edge Case Handling

| Edge Case | Behavior |
|-----------|----------|
| Duplicate usernames in `defaultUsers` | Nix deduplicates automatically |
| Special characters in `initialPassword` | Passed through verbatim |
| `initialPassword` set but user not in any host | No error; password unused |
| Empty string in `defaultUsers` array | Ignored (no user created) |
| Re-building with existing users | Idempotent; no duplicates |

---

## Module Interfaces

### Host Module (`modules/host/default.nix`)

```nix
{ config, lib, pkgs, ... }:
{
  options = {
    defaultUsers = {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of usernames to create on this host";
    };
  };

  config = {
    # User creation logic based on defaultUsers
  };
}
```

### User Module (implicit, via `users/<name>/default.nix`)

```nix
{ config, lib, pkgs, ... }:
{
  options = {
    initialPassword = {
      type = lib.types.str;
      default = "";
      description = "Initial password for user (empty = locked)";
    };
  };

  config = {
    # User attribute definitions
  };
}
```

---

## Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│  hosts/<hostname>/config.nix                                │
│  ┌───────────────────────────────────────────────────────┐  │
│  │ defaultUsers = [ "alice" "bob" ];                     │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
         │                    │
         │ references         │ references
         v                    v
┌─────────────────┐  ┌─────────────────┐
│ users/alice/    │  │ users/bob/      │
│ default.nix     │  │ default.nix     │
│ ┌─────────────┐ │  │ ┌─────────────┐ │
│ │initialPass  │ │  │ │initialPass  │ │
│ │extraGroups  │ │  │ │extraGroups  │ │
│ └─────────────┘ │  │ └─────────────┘ │
└─────────────────┘  └─────────────────┘
         │                    │
         v                    v
┌─────────────────────────────────────────────────────────────┐
│  NixOS users.users.alice / users.users.bob                  │
│  (system user accounts created during build)                │
└─────────────────────────────────────────────────────────────┘
```
