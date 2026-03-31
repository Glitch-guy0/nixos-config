# Quickstart: User Configuration Cleanup

## Prerequisites

- Nix with flake support
- This repository cloned

## Cleanup Steps

### 1. Verify Current State

```bash
# Check current defaultUsers in host config
cat hosts/unknown/config.nix | grep defaultUsers

# Verify users directory contents
ls users/
```

### 2. Run Cleanup

The cleanup involves updating two files:

1. **hosts/unknown/config.nix**: Change `defaultUsers = ["alice" "bob"]` to `defaultUsers = ["glitch"]`
2. **docs/end-user/users.md**: Update examples from alice/bob to glitch

### 3. Validate

```bash
# Check Nix expressions are valid
nix flake check

# Build the host to verify
nixos-rebuild build --flake .#unknown
```

### 4. Expected Outcome

- Host "unknown" builds successfully
- User "glitch" is created on the system
- No references to alice/bob in active configuration files
- Documentation reflects current state

## Rollback

If issues occur, revert changes with:
```bash
git checkout hosts/unknown/config.nix docs/end-user/users.md
```

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Build fails | Check that users/glitch/default.nix exists |
| User not created | Verify defaultUsers includes "glitch" |
| Doc shows old users | Update examples in docs/end-user/users.md |
