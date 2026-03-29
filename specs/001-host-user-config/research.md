# Research: Host User Configuration

**Date**: 2026-03-29
**Feature**: Host User Configuration (001-host-user-config)

## Research Topics

### 1. Password Management in NixOS

**Decision**: Use `users.users.<name>.hashedPassword` with plaintext password option for initial setup only

**Rationale**: 
- NixOS provides `users.users.<name>.password` for plaintext passwords (hashed automatically)
- For production, `hashedPassword` is preferred to avoid storing plaintext in nix store
- Since this is initial provisioning password (to be changed on first login), plaintext is acceptable
- For enhanced security, future iteration can integrate sops-nix for encrypted password storage

**Alternatives Considered**:
1. **sops-nix integration**: More secure but adds complexity; deferred to future iteration
2. **SSH keys only**: Excludes password-based initial access; not suitable for all use cases
3. **No initial password**: Users would need alternative access method; reduces usability

**Reference**: NixOS Manual - users.groups module

---

### 2. NixOS User Creation Patterns

**Decision**: Use standard NixOS `users.users` and `users.groups` modules

**Rationale**:
- Built-in NixOS module provides declarative user management
- Idempotent by design (re-applying doesn't break)
- Integrates with Home Manager for user-specific configurations
- Supports all required features: password, groups, shell, home directory

**Best Practices**:
- Define user attributes in shared `users/<name>/default.nix`
- Host configs declare which users exist via `defaultUsers` list
- Use `extraUsers` for host-specific user overrides

**Reference**: NixOS Options Documentation - users.groups module

---

### 3. Module Option Design for defaultUsers

**Decision**: Define `defaultUsers` as array of strings in host module

**Rationale**:
- Array of strings is idiomatic Nix for lists
- Empty array `[]` provides clear "no users" default
- Easy to validate and iterate over for user creation
- Compatible with NixOS module system type checking

**Option Definition Pattern**:
```nix
{
  options.defaultUsers = {
    type = types.listOf types.str;
    default = [];
    description = "List of usernames to create on this host";
  };
}
```

**Alternatives Considered**:
1. **Submodule with user attributes**: Too verbose; user attributes belong in user configs
2. **Attribute set of users**: Less intuitive for simple "which users exist" declaration

---

### 4. User Configuration Structure

**Decision**: User configs in `users/<name>/default.nix` with `initialPassword` option

**Rationale**:
- Mirrors host structure (`hosts/<hostname>/default.nix`)
- Clear separation: host declares *which* users, user config declares *how* user is configured
- Enables user reuse across multiple hosts
- Follows existing project patterns for modularity

**User Config Pattern**:
```nix
{
  options.initialPassword = {
    type = types.str;
    default = "";
    description = "Initial password (empty = no password/locked account)";
  };
  
  options.extraGroups = {
    type = types.listOf types.str;
    default = [];
  };
  
  # ... other user-specific options
}
```

---

### 5. Idempotency in User Creation

**Decision**: Rely on NixOS declarative model for idempotency

**Rationale**:
- NixOS `users.users` is inherently idempotent
- Re-applying same configuration produces identical system state
- User removal from `defaultUsers` preserves existing accounts (per requirements)
- No additional state tracking required

**Implementation Note**:
- User account persistence is default NixOS behavior
- Removing user from config requires explicit `users.mutableUsers = false` to delete
- Our design keeps `mutableUsers = true` (default) to preserve accounts

---

### 6. Integration with Existing Project Structure

**Decision**: Create new `modules/host/` directory for host module

**Rationale**:
- Aligns with existing `modules/` directory for reusable components
- Separates host-level options from user-level options
- Enables composition in `flake.nix` via imports

**File Placement**:
- `modules/host/default.nix` - Host module with `defaultUsers` option
- `users/<name>/default.nix` - User-specific configurations
- `hosts/<hostname>/default.nix` - Host configs importing host module

---

## Resolved Clarifications

| Unknown | Resolution |
|---------|------------|
| Password security approach | Plaintext `password` option for initial setup; sops-nix deferred |
| User creation mechanism | NixOS `users.users` module |
| defaultUsers option type | `types.listOf types.str` with `default = []` |
| User config location | `users/<name>/default.nix` |
| Idempotency approach | Rely on NixOS declarative model |
| Module structure | `modules/host/` for host module |

## Next Steps

1. **Phase 1**: Generate `data-model.md` with entity definitions
2. **Phase 1**: Create Nix module contracts for `defaultUsers` and `initialPassword`
3. **Phase 1**: Generate `quickstart.md` with usage examples
4. **Phase 1**: Update agent context with new technology patterns
