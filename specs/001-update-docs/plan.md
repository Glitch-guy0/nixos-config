# Implementation Plan: Documentation Overhaul

**Branch**: `001-update-docs` | **Date**: 2026-03-24 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification for documentation overhaul

## Summary

**Primary Requirement**: Replace all existing documentation (`docs/` directory and `USER_GUIDE.md`) with a new audience-based structure that separates content for End Users, Developers, and Contributors.

**Technical Approach**: Phased delivery starting with core operations (installation, profile switching, troubleshooting), expanding to comprehensive architecture and migration guides in follow-up phases. Documentation will use clean technical style with Markdown format.

## Technical Context

**Language/Version**: Nix (Flakes), Markdown for documentation
**Primary Dependencies**: NixOS, Home Manager, sops-nix, age encryption
**Storage**: N/A (documentation feature)
**Testing**: Manual validation of documented commands, user feedback testing
**Target Platform**: NixOS systems (Linux)
**Project Type**: Documentation (technical writing)
**Performance Goals**: Users complete installation in <60 minutes, find answers within 2 minutes
**Constraints**: Documentation must be accurate, tested, and reflect current repository state
**Scale/Scope**: Phase 1 covers core operations; comprehensive coverage in subsequent phases

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Modularity First | ✅ Pass | Documentation structure is modular by audience |
| II. Flake-Based Architecture | ✅ Pass | Documentation will reflect flake.nix as entry point |
| III. Declarative by Default | ✅ Pass | N/A (documentation feature) |
| IV. Composability | ✅ Pass | Documentation sections composable by audience |
| V. Documentation Synchronization | ✅ Pass | This feature directly addresses doc sync |
| VI. Separation of Concerns | ✅ Pass | Audience-based separation aligns with principle |

**GATE RESULT**: ✅ PASS - No violations. Proceed to Phase 0.

**POST-PHASE 1 RE-EVALUATION**: ✅ PASS - Design artifacts align with constitution principles. Audience-based documentation structure maintains separation of concerns and modularity.

## Project Structure

### Documentation (this feature)

```text
specs/001-update-docs/
├── plan.md              # This file
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output (N/A for documentation)
├── quickstart.md        # Phase 1 output (N/A for documentation)
├── contracts/           # Phase 1 output (N/A for documentation)
└── tasks.md             # Phase 2 output (created by /speckit.tasks)
```

### Source Code (repository root)

```text
/Users/prajwal/Documents/nixos-config/
├── docs/                    # DELETE ALL EXISTING, CREATE NEW
│   ├── end-user/           # New: End User documentation
│   │   ├── installation.md
│   │   ├── profile-switching.md
│   │   └── troubleshooting.md
│   ├── developer/          # New: Developer documentation
│   │   ├── adding-host.md
│   │   ├── adding-module.md
│   │   └── adding-profile.md
│   └── contributor/        # New: Contributor documentation
│       ├── architecture.md
│       └── workflows.md
├── USER_GUIDE.md           # DELETE - replaced by docs/end-user/
├── specs/001-update-docs/  # Feature spec and artifacts
└── scripts/                # Existing scripts (must remain functional)
```

**Structure Decision**: Audience-based directory structure under `docs/` with three distinct sections (end-user, developer, contributor). `USER_GUIDE.md` will be deleted and replaced by `docs/end-user/` content.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | No constitution violations | N/A |

**Complexity Level**: Standard (documentation feature with clear scope)
