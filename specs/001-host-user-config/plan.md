# Implementation Plan: Host User Configuration

**Branch**: `001-host-user-config` | **Date**: 2026-03-29 | **Spec**: [specs/001-host-user-config/spec.md](./spec.md)
**Input**: Feature specification from `/specs/001-host-user-config/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Add `defaultUsers` configuration option to host configs (array of usernames) and `initialPassword` option to user-specific configs. Users are created during host provisioning with password authentication. User definitions live in shared `users/<name>/default.nix` files; host configs declare which users exist on that specific host.

## Technical Context

**Language/Version**: Nix (Flakes) with NixOS 24.05+
**Primary Dependencies**: NixOS users.groups module, Home Manager (for user-level config)
**Storage**: N/A (system configuration, not application data)
**Testing**: nix flake check, nixos-rebuild dry-run
**Target Platform**: NixOS systems (Linux)
**Project Type**: System configuration (NixOS flake)
**Performance Goals**: N/A (configuration, not runtime software)
**Constraints**: Must be declarative, idempotent, reproducible builds
**Scale/Scope**: Single repository, multi-host configuration

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

### Gate 1: Modularity First (Core Principle I)
- **Status**: PASS
- **Rationale**: User configuration will be modularized in `users/<name>/default.nix`, host configs reference users declaratively.

### Gate 2: Flake-Based Architecture (Core Principle II)
- **Status**: PASS
- **Rationale**: All configuration flows through existing `flake.nix`; no imperative access required.

### Gate 3: Declarative by Default (Core Principle III)
- **Status**: PASS
- **Rationale**: User creation via NixOS `users.users` option is fully declarative.

### Gate 4: Composability (Core Principle IV)
- **Status**: PASS
- **Rationale**: User configs are composable across hosts; no duplication.

### Gate 5: Documentation Synchronization (Core Principle V)
- **Status**: PASS (pending)
- **Rationale**: Documentation updates are part of the feature requirements (FR-010).

### Gate 6: Separation of Concerns (Core Principle VI)
- **Status**: PASS
- **Rationale**: Architecture/logic handled by nix-expert patterns; documentation by nix-docs-writer.

### Gate 7: Documentation as Source of Truth (Core Principle VII)
- **Status**: PASS (pending)
- **Rationale**: Will ensure docs/ reflects new configuration options.

### Gate 8: Nix Configuration Governance
- **Status**: PASS
- **Rationale**: Two-agent workflow will be followed (nix-expert validation + nix-docs-writer documentation).

### Gate 9: Security Principles (VIII-XI)
- **Status**: PASS
- **Rationale**: `initialPassword` uses NixOS `users.users.<name>.password` option. For initial provisioning, plaintext is acceptable (password changed on first login). Production deployments can integrate sops-nix in future iteration.

### Gate 10: Testing Principles (XII-XV)
- **Status**: PASS
- **Rationale**: Will validate with `nix flake check` and `nixos-rebuild build --dry-run`. Module structure follows existing patterns.

## Project Structure

### Documentation (this feature)

```text
specs/001-host-user-config/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command) - N/A for this feature
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
modules/
├── host/
│   └── default.nix      # Host module with defaultUsers option
users/
├── alice/
│   └── default.nix      # User-specific config with initialPassword
└── bob/
    └── default.nix      # Another user config
hosts/
├── [hostname]/
│   └── default.nix      # Host config referencing defaultUsers
```

**Structure Decision**: Single project structure. User configs in `users/<name>/default.nix`, host module in `modules/host/`, host-specific configs in `hosts/[hostname]/`.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| [e.g., 4th project] | [current need] | [why 3 projects insufficient] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient] |
