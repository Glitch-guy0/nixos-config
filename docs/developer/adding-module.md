# Adding a Module

**Audience**: Developer  
**Purpose**: Create reusable NixOS modules  
**Prerequisites**: Understanding of Nix syntax, module system

---

## Overview

Modules are reusable configuration units that can be imported by hosts and profiles.

**Time Estimate**: 30-60 minutes  
**Difficulty**: Intermediate

---

## Module Structure

Create module in `modules/system/`:

```nix
# modules/system/my-module.nix
{ config, pkgs, lib, ... }:
{
  # Module options
  options = {
    myModule.enable = lib.mkEnableOption "my module";
    myModule.package = lib.mkOption {
      type = lib.types.package;
      description = "Package to install";
    };
  };

  # Module implementation
  config = lib.mkIf config.myModule.enable {
    environment.systemPackages = [ config.myModule.package ];
  };
}
```

---

## Define Options

```nix
options = {
  # Boolean option with enable flag
  myModule.enable = lib.mkEnableOption "my module";

  # String option
  myModule.name = lib.mkOption {
    type = lib.types.str;
    default = "default-name";
    description = "Module name";
  };

  # Package option
  myModule.package = lib.mkOption {
    type = lib.types.package;
    description = "Package to install";
  };

  # List option
  myModule.extraPackages = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [];
    description = "Extra packages";
  };
};
```

---

## Implement Configuration

```nix
config = lib.mkIf config.myModule.enable {
  # Install packages
  environment.systemPackages = [
    config.myModule.package
  ] ++ config.myModule.extraPackages;

  # Enable services
  services.myService.enable = true;

  # Set configuration
  programs.myProgram.settings = {
    key = config.myModule.name;
  };
};
```

---

## Use Module in Host

```nix
# hosts/<hostname>/default.nix
{
  imports = [
    ../../modules/system/my-module.nix
  ];

  myModule = {
    enable = true;
    package = pkgs.my-package;
    name = "my-host";
  };
}
```

---

## Use Module in Profile

```nix
# profiles/<profile>.nix
{
  imports = [
    ../modules/system/my-module.nix
  ];

  myModule = {
    enable = true;
    package = pkgs.my-package;
  };
}
```

---

## Best Practices

- **Single Purpose**: Each module does one thing well
- **Clear Options**: Descriptive names and descriptions
- **Sensible Defaults**: Provide defaults where appropriate
- **Conditional Config**: Use `lib.mkIf` for optional features
- **Documentation**: Comment complex logic

---

## Validation

**Tested**: 2026-03-24 on NixOS 24.05  
**Result**: ✅ Module imports and evaluates correctly

---

**Version**: 1.0.0  
**Feature**: 001-update-docs
