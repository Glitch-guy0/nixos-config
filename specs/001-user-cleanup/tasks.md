# Tasks: User Configuration Cleanup

**Feature**: User Configuration Cleanup | **Branch**: `001-user-cleanup` | **Date**: 2026-03-31

## Overview

This file contains executable tasks for the user configuration cleanup feature. Tasks are organized by user story to enable independent implementation and testing.

## Phase 1: Setup

- [X] T001 Verify prerequisites: Check that flake.nix structure is intact

## Phase 2: Foundational

- [X] T002 Verify current state: Confirm alice/bob are not in users/ directory but are referenced in hosts/unknown/config.nix
- [X] T003 Verify target state: Confirm glitch user exists in users/glitch/default.nix

## Phase 3: User Story 1 - Clean Up Removed Users (P1)

**Goal**: Remove all references to users "alice" and "bob" from host configuration and update to use "glitch"

**Independent Test**: After cleanup, `nixos-rebuild build --flake .#unknown` should succeed without errors related to missing user configurations

**Implementation Tasks**:

- [X] T004 [P] [US1] Update hosts/unknown/config.nix: Change defaultUsers from ["alice" "bob"] to ["glitch"]
- [X] T005 [US1] Validate: Run `nix flake check` to verify Nix expressions are valid
- [X] T006 [US1] Validate: Run `nixos-rebuild build --flake .#unknown` to verify host builds successfully

## Phase 4: User Story 2 - Update Existing User Configuration (P2)

**Goal**: Ensure the existing "glitch" user is properly integrated into the host configuration

**Independent Test**: The host "unknown" should build successfully with the "glitch" user properly configured and accessible

**Implementation Tasks**:

- [X] T007 [P] [US2] Update docs/end-user/users.md: Replace alice/bob examples with glitch in user configuration examples
- [X] T008 [US2] Validate: Verify docs/end-user/users.md shows correct current state

## Phase 5: Polish & Cross-Cutting Concerns

- [X] T009 Create cleanup log documenting all locations where alice/bob references were removed
- [X] T010 Final validation: Run full `nix flake check` to ensure no regressions

---

## Dependency Graph

```
T001 → T002 → T003 → T004 → T005 → T006 → T007 → T008 → T009 → T010
                       ↓
                   (US1 can complete before US2 starts)
```

## Parallel Execution Opportunities

| Tasks | Reason |
|-------|--------|
| T004 and T007 | Different files (hosts/unknown/config.nix vs docs/end-user/users.md) - can execute in parallel |
| T005 and T008 | Both validation tasks - can run in parallel |

## Independent Test Criteria

| User Story | Test Command | Expected Result |
|-----------|--------------|-----------------|
| US1: Clean Up Removed Users | `nixos-rebuild build --flake .#unknown` | Build succeeds without user-related errors |
| US2: Update Existing User | `nix flake check` | All checks pass |

## Implementation Strategy

**MVP Scope**: User Story 1 (T001-T006)
- Core cleanup: Update hosts/unknown/config.nix to use glitch instead of alice/bob
- Validate build succeeds

**Incremental Delivery**:
1. First complete Phase 1-3 (US1) - this fixes the critical build issue
2. Then complete Phase 4 (US2) - documentation update
3. Final polish in Phase 5

## Summary

- **Total Tasks**: 10
- **User Story 1 Tasks**: 3 (T004-T006)
- **User Story 2 Tasks**: 2 (T007-T008)
- **Parallelizable Tasks**: 2 (T004, T007)
- **MVP Scope**: User Story 1 (T001-T006)
