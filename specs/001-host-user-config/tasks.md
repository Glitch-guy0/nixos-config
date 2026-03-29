# Tasks: Host User Configuration

**Input**: Design documents from `/specs/001-host-user-config/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, quickstart.md

**Tests**: Tests are OPTIONAL - not explicitly requested in feature specification. Validation via `nix flake check` and `nixos-rebuild --dry-run` is sufficient.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- Host module: `modules/host/default.nix`
- User configs: `users/<name>/default.nix`
- Host configs: `hosts/<hostname>/config.nix`
- Documentation: `docs/` directory

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Create module directory structure and verify existing patterns

- [ ] T001 Create `modules/host/` directory for host-level module
- [ ] T002 Review existing `modules/system/default.nix` for module patterns
- [ ] T003 Review existing `users/glitch/default.nix` for user config patterns

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core module infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T004 Create `modules/host/default.nix` with basic module structure (imports, options, config)
- [ ] T005 Add module header comments (PURPOSE, SCOPE pattern from existing modules)
- [ ] T006 Verify module imports work in `flake.nix` or hosts builder

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Configure Default Users for Host (Priority: P1) 🎯 MVP

**Goal**: Implement `defaultUsers` option in host module that creates users during system build

**Independent Test**: Configure a host with `defaultUsers = [ "alice" "bob" ]` and verify users are created via `nixos-rebuild build --flake .#hostname`

### Implementation for User Story 1

- [ ] T007 [P] [US1] Define `defaultUsers` option in `modules/host/default.nix` (type: listOf str, default: [])
- [ ] T008 [US1] Implement user creation logic in `modules/host/default.nix` config section using NixOS `users.users` module
- [ ] T009 [US1] Add logic to read user configs from `users/<name>/default.nix` for each user in `defaultUsers`
- [ ] T010 [US1] Handle edge case: empty `defaultUsers` list creates no users (backward compatibility)
- [ ] T011 [US1] Handle edge case: `defaultUsers` not specified defaults to empty list
- [ ] T012 [US1] Add module documentation comment for `defaultUsers` option (description field)
- [ ] T013 [US1] Create example user config `users/alice/default.nix` (basic structure, no password yet)
- [ ] T014 [US1] Create example user config `users/bob/default.nix` (basic structure, no password yet)
- [ ] T015 [US1] Update `hosts/unknown/config.nix` to demonstrate `defaultUsers = [ "alice" "bob" ]` usage
- [ ] T016 [US1] Add logging/trace output for user creation in module config

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently - users are created but without passwords

---

## Phase 4: User Story 2 - Set Initial Password for Default Users (Priority: P2)

**Goal**: Implement `initialPassword` option in user configs that sets password when user is created

**Independent Test**: Configure `initialPassword` in `users/alice/default.nix`, add alice to host `defaultUsers`, verify password authentication works

### Implementation for User Story 2

- [ ] T017 [P] [US2] Define `initialPassword` option in user config pattern (type: str, default: "")
- [ ] T018 [US2] Update `users/alice/default.nix` with `initialPassword = "TempPass123!";`
- [ ] T019 [US2] Update `users/bob/default.nix` with `initialPassword` (different password for testing)
- [ ] T020 [US2] Implement password application logic in `modules/host/default.nix` to read `initialPassword` from user configs
- [ ] T021 [US2] Apply password to NixOS `users.users.<name>.password` when user is in `defaultUsers`
- [ ] T022 [US2] Handle edge case: `initialPassword` set but user not in any host's `defaultUsers` (no error)
- [ ] T023 [US2] Handle edge case: empty string `initialPassword = ""` creates locked account
- [ ] T024 [US2] Add module documentation comment for password handling
- [ ] T025 [US2] Verify idempotency: re-applying config doesn't break existing users

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently - users created with passwords

---

## Phase 5: User Story 3 - Document Configuration Options (Priority: P3)

**Goal**: Create clear documentation for `defaultUsers` and `initialPassword` options

**Independent Test**: Review documentation and verify it accurately describes configuration options with usage examples

### Implementation for User Story 3

- [ ] T026 [P] [US3] Create `docs/users.md` documenting user configuration system overview
- [ ] T027 [US3] Document `defaultUsers` option in `docs/users.md` with array syntax examples
- [ ] T028 [US3] Document `initialPassword` option in `docs/users.md` with usage examples
- [ ] T029 [US3] Document relationship between host config and user config
- [ ] T030 [US3] Add troubleshooting section (user not created, password not working)
- [ ] T031 [US3] Add security notes (password in nix store, change on first login)
- [ ] T032 [US3] Update `CHANGELOG.md` with new feature description
- [ ] T033 [US3] Verify documentation matches actual implementation (no drift)

**Checkpoint**: All user stories should now be independently functional and documented

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T034 [P] Run `nix flake check` to validate flake structure
- [ ] T035 [P] Run `nixos-rebuild build --dry-run --flake .#unknown` to validate configuration
- [ ] T036 [P] Verify `quickstart.md` examples work with actual implementation
- [ ] T037 Code cleanup: ensure consistent formatting with `nixfmt-rfc-style`
- [ ] T038 Verify no circular imports in module structure
- [ ] T039 [P] Final review of `data-model.md` accuracy against implementation
- [ ] T040 [P] Final review of `spec.md` acceptance criteria completion

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Phase 6)**: Depends on all user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after User Story 1 (needs user creation logic first)
- **User Story 3 (P3)**: Can start after US1 + US2 complete (must document actual behavior)

### Within Each User Story

- Models/options before implementation logic
- Core implementation before edge cases
- Edge cases before integration examples
- Story complete before moving to next priority

### Parallel Opportunities

- T001, T002, T003 (Setup) can run in parallel
- T004, T005, T006 (Foundational) can run in parallel
- T007, T013, T014 (US1 option + example users) can run in parallel
- T017, T018, T019 (US2 option + example passwords) can run in parallel
- T026, T032 (US3 docs + changelog) can run in parallel
- T034, T035, T036 (Polish validation) can run in parallel

---

## Parallel Example: User Story 1

```bash
# Launch option definition and example user creation together:
Task: "Define defaultUsers option in modules/host/default.nix"
Task: "Create users/alice/default.nix (basic structure)"
Task: "Create users/bob/default.nix (basic structure)"

# After option is defined, implement logic:
Task: "Implement user creation logic in modules/host/default.nix"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test `defaultUsers` creates users without passwords
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Module infrastructure ready
2. Add User Story 1 → Users created (no password) → Test independently
3. Add User Story 2 → Users created with passwords → Test independently
4. Add User Story 3 → Documentation complete → Verify accuracy
5. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1 (defaultUsers implementation)
   - Developer B: User Story 2 prep (user config structure)
3. After US1 complete:
   - Developer A: User Story 2 (password integration)
   - Developer B: User Story 3 (documentation)
4. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Validation: Use `nix flake check` and `nixos-rebuild --dry-run` instead of unit tests
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break independence

---

## Task Summary

| Phase | Task Count | Description |
|-------|------------|-------------|
| Phase 1: Setup | 3 | Module directory structure |
| Phase 2: Foundational | 3 | Core module infrastructure |
| Phase 3: US1 (P1) | 10 | defaultUsers option + user creation |
| Phase 4: US2 (P2) | 9 | initialPassword option + password application |
| Phase 5: US3 (P3) | 8 | Documentation |
| Phase 6: Polish | 7 | Validation and cleanup |
| **Total** | **40** | |

**MVP Scope**: Phases 1-3 (16 tasks) - Users can be created on hosts without passwords

**Parallel Opportunities**: 12 tasks marked [P] can run in parallel within their phases
