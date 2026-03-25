# Contributor Workflows

**Audience**: Contributor  
**Purpose**: Development and contribution workflows  
**Prerequisites**: Git, NixOS basics, repository understanding

---

## Overview

Workflows for contributing to this NixOS configuration repository.

**Time Estimate**: Varies by task  
**Difficulty**: Intermediate to Advanced

---

## Repository Structure

```
nixos-config/
├── hosts/          # Machine configurations
├── profiles/       # User environment bundles
├── modules/        # Reusable modules
├── pkgs/           # Custom packages
├── scripts/        # Automation scripts
├── secrets/        # Encrypted secrets
└── specs/          # Feature specifications
```

---

## Development Workflow

### 1. Clone Repository

```bash
git clone https://github.com/your-username/nixos-config.git
cd nixos-config
```

### 2. Create Feature Branch

```bash
git checkout -b feature/my-change
```

### 3. Make Changes

Edit configuration files following the [style guide](../STYLE.md).

### 4. Validate Changes

```bash
# Run linting and validation
./scripts/check.sh
```

### 5. Test Build

```bash
# Test flake
nix flake check

# Test build
sudo nixos-rebuild build --flake .#hostname
```

### 6. Commit Changes

```bash
git add .
git commit -m "Description of changes"
```

### 7. Push and PR

```bash
git push origin feature/my-change
```

---

## Adding a New Feature

### Step 1: Create Specification

```bash
# Run spec command
/speckit.specify "Feature description"
```

### Step 2: Generate Plan

```bash
# Run plan command
/speckit.plan
```

### Step 3: Generate Tasks

```bash
# Run tasks command
/speckit.tasks
```

### Step 4: Implement

Follow tasks in `specs/###-feature/tasks.md`.

### Step 5: Validate

```bash
# Run validation
./scripts/check.sh
```

---

## Testing Changes

### Test on Disposable VM

```bash
# Create test VM
nixos-rebuild build-vm --flake .#hostname

# Run VM
./result/bin/run-nixos-vm
```

### Test Profile Switch

```bash
# Test profile
home-manager switch --flake .#username@profile --dry-run
```

---

## Validation Commands

### Flake Check

```bash
nix flake check
```

### Build Test

```bash
sudo nixos-rebuild build --flake .#hostname
```

### Linting

```bash
./scripts/check.sh
```

---

## Common Tasks

### Update Flake Inputs

```bash
nix flake update
```

### Garbage Collection

```bash
# Clean old generations
nix-collect-garbage -d

# Optimize store
nix-store --optimize
```

### Rekey Secrets

```bash
# After adding new key
./scripts/sops/rekey-all.sh
```

---

## Code Review Checklist

Before submitting PR:

- [ ] Changes validated with `./scripts/check.sh`
- [ ] Build succeeds locally
- [ ] Documentation updated
- [ ] No secrets or keys committed
- [ ] Commit message clear
- [ ] Feature branch (not main)

---

## Troubleshooting

### Build Fails

```bash
# Get detailed error
nixos-rebuild build --flake .#hostname --show-trace
```

### Flake Check Fails

```bash
# Check specific error
nix flake check --print-build-logs
```

### Import Errors

```bash
# Verify imports
nix eval --flake .#nixosConfigurations.hostname
```

---

## Best Practices

- **Small Changes**: One logical change per PR
- **Test First**: Validate before committing
- **Document**: Update docs for user-visible changes
- **Follow Style**: Adhere to repository conventions
- **Review**: Self-review before submitting

---

## Getting Help

- **Documentation**: Check `docs/` directory
- **Constitution**: Read `CONSTITUTION.md` for principles
- **Scripts**: Review `scripts/` for automation
- **Issues**: Check existing issues before creating new

---

**Version**: 1.0.0  
**Feature**: 001-update-docs
