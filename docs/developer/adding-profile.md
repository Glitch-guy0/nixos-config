# Adding a Profile

**Audience**: Developer  
**Purpose**: Create new user profiles  
**Prerequisites**: Understanding of [existing profiles](../end-user/profiles-overview.md), Nix basics

---

## Overview

Profiles are capability bundles that define user environments with specific tooling.

**Time Estimate**: 20-40 minutes  
**Difficulty**: Intermediate

---

## Profile Structure

Create profile in `profiles/`:

```nix
# profiles/<profile-name>.nix
{ pkgs, ... }:
{
  # Import base profile
  imports = [
    ./base.nix
  ];

  # Add profile-specific packages
  home.packages = with pkgs; [
    # Profile-specific packages
  ];

  # Configure programs
  programs = {
    # Program configurations
  };
}
```

---

## Example: Custom Profile

```nix
# profiles/data-scientist.nix
{ pkgs, ... }:
{
  # Import base
  imports = [
    ./base.nix
  ];

  # Data science packages
  home.packages = with pkgs; [
    python311
    python311Packages.numpy
    python311Packages.pandas
    python311Packages.jupyter
    rWrapper
  ];

  # Configure shell
  programs.bash = {
    enable = true;
    shellAliases = {
      py = "python";
    };
  };
}
```

---

## Profile Composition

### Import Multiple Profiles

```nix
# profiles/power-user.nix
{ pkgs, ... }:
{
  imports = [
    ./base.nix
    ./developer.nix
    ./gaming.nix
  ];

  # Override or add to imported profiles
  home.packages = with pkgs; [
    # Additional packages
  ];
}
```

### Extend Existing Profile

```nix
# profiles/developer-plus.nix
{ pkgs, ... }:
{
  imports = [
    ./developer.nix
  ];

  # Add to developer profile
  home.packages = with pkgs; [
    # Extra developer tools
    docker
    kubernetes
  ];
}
```

---

## Use Profile

```bash
# Switch to new profile
home-manager switch --flake .#<username>@<profile-name>
```

---

## Profile Guidelines

- **Clear Purpose**: Each profile serves a specific use case
- **Import Base**: Start with `base.nix` for essentials
- **Document**: Comment what the profile is for
- **Test**: Verify profile switches correctly
- **Name Clearly**: Use descriptive profile names

---

## Validation

**Tested**: 2026-03-24 on NixOS 24.05  
**Result**: ✅ Profile switches and packages available

---

**Version**: 1.0.0  
**Feature**: 001-update-docs
