# Contributing Guide

## Pre/post change checklists
1. Follow SOLID principles (as detailed in `CONSTITUTION.md`).
2. Add inline documentation standard headers to every `.nix` file.
3. Validate changes with `scripts/check.sh` before committing.
4. Update `.sops.yaml` and re-key secrets if necessary.
5. Record changes in `CHANGELOG.md`.

## Style guide
- Format code via `nixfmt-rfc-style`.
- Keep modules single-purpose.
