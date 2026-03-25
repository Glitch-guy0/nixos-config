# Profile Switching

**Audience**: End User  
**Purpose**: Switch between user profiles  
**Prerequisites**: Completed [installation](installation.md), understand [profiles](profiles-overview.md)

---

## Overview

Switch your user environment by changing profiles. No root access required.

**Time Estimate**: 5-10 minutes  
**Difficulty**: Beginner

---

## Quick Start

```bash
# Navigate to project root
cd /path/to/nixos-config

# Switch to a profile
home-manager switch --flake .#<username>@<profile>
```

Replace:
- `<username>` with your username
- `<profile>` with profile name (e.g., `developer`, `gaming`)

---

## Examples

### Switch to Developer Profile

```bash
home-manager switch --flake .#glitch@developer
```

### Switch to Minimal Profile

```bash
home-manager switch --flake .#glitch@minimal
```

### Switch to Gaming Profile

```bash
home-manager switch --flake .#glitch@gaming
```

---

## Testing Profiles

### Test Without Committing

```bash
# Test a profile without switching permanently
home-manager switch --flake .#<username>@<profile>
```

### Use Intermediate Flake

```bash
# Test using standalone intermediate flake
home-manager switch --flake ./users#<username>@<profile>
```

---

## Verify Profile Switch

```bash
# Check active profile
home-manager --version

# Verify installed packages
which <package-from-profile>
```

**Expected**: Package from new profile should be available.

---

## Common Scenarios

### Scenario 1: Daily Driver → Development

```bash
# Switch from base to developer
home-manager switch --flake .#glitch@developer
```

### Scenario 2: Work → Gaming

```bash
# Switch from developer to gaming
home-manager switch --flake .#glitch@gaming
```

### Scenario 3: Recovery Mode

```bash
# Switch to minimal for troubleshooting
home-manager switch --flake .#glitch@minimal
```

---

## Rollback

If something goes wrong:

```bash
# Rollback to previous generation
home-manager switch --rollback
```

---

## Troubleshooting

### Profile Switch Fails

**Error**: "attribute 'xyz' missing"

**Solution**: 
1. Verify profile name is correct
2. Check username matches
3. Ensure flake is in project root

### Packages Not Available

**Symptoms**: Command not found after switch

**Solution**:
1. Wait for activation to complete
2. Open new terminal session
3. Verify profile includes the package

### Switch Takes Too Long

**Symptoms**: Activation hangs

**Solution**:
1. Check internet connection (downloading packages)
2. Cancel with Ctrl+C
3. Retry with `--show-trace` for debugging

---

## Best Practices

- **Test first**: Try profile before making it permanent
- **One at a time**: Don't switch multiple profiles rapidly
- **Verify**: Check packages are available after switch
- **Rollback ready**: Know how to rollback if needed

---

## Next Steps

- [Profiles Overview](profiles-overview.md) - Learn about available profiles
- [Troubleshooting](troubleshooting.md) - Common issues
- [Secrets Management](secrets-management.md) - Configure secrets

---

## Validation

**Tested**: 2026-03-24 on NixOS 24.05  
**Test Environment**: unknown host  
**Result**: ✅ Profile switches complete successfully

---

**Version**: 1.0.0  
**Feature**: 001-update-docs
