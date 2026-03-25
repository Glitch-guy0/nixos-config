# Tasks: Documentation Overhaul

**Input**: Design documents from `/specs/001-update-docs/`
**Prerequisites**: plan.md, spec.md, research.md, quickstart.md

**Tests**: Not included - this is a documentation feature. Validation is done through manual testing of documented commands and user feedback.

**Organization**: Tasks are grouped by user story to enable independent documentation and validation of each audience section.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Documentation structure**: `docs/end-user/`, `docs/developer/`, `docs/contributor/`
- **Root files**: `USER_GUIDE.md` (to be deleted)
- All paths are relative to repository root

---

## Phase 1: Setup (Documentation Infrastructure)

**Purpose**: Prepare repository for new documentation structure

- [x] T001 Delete all existing files in `docs/` directory
- [x] T002 Delete `USER_GUIDE.md` from repository root
- [x] T003 [P] Create `docs/end-user/` directory structure
- [x] T004 [P] Create `docs/developer/` directory structure
- [x] T005 [P] Create `docs/contributor/` directory structure
- [x] T006 Create documentation style guide in `docs/STYLE.md` (headers, callouts, code blocks, tone)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core documentation infrastructure that MUST be complete before ANY user story documentation can be written

**⚠️ CRITICAL**: No user story documentation work can begin until this phase is complete

- [x] T007 Create `docs/README.md` with audience-based navigation structure
- [x] T008 Define command validation protocol in `docs/VALIDATION.md`
- [x] T009 Create user testing protocol template in `docs/TESTING.md`
- [x] T010 Setup documentation cross-references and linking conventions
- [x] T011 Create documentation checklist template for Phase 1 validation

**Checkpoint**: Foundation ready - user story documentation can now begin in parallel

---

## Phase 3: User Story 1 - New User Installation (Priority: P1) 🎯 MVP

**Goal**: Complete installation documentation that enables first-time users to install NixOS successfully

**Independent Test**: A user with no prior knowledge can follow the documentation to successfully install NixOS on their machine

### Implementation for User Story 1

- [x] T012 [P] [US1] Write `docs/end-user/installation.md` with complete installation steps
- [x] T013 [P] [US1] Write `docs/end-user/new-host-setup.md` for creating new host configurations
- [x] T014 [P] [US1] Write `docs/end-user/secrets-management.md` for age key generation and secrets
- [x] T015 [US1] Test all commands in installation.md (execute and verify)
- [x] T016 [US1] Test all commands in new-host-setup.md (execute and verify)
- [x] T017 [US1] Test all commands in secrets-management.md (execute and verify)
- [x] T018 [US1] Add troubleshooting section for common installation errors
- [x] T019 [US1] Add expected output examples for each command
- [ ] T020 [US1] Recruit 3 testers with varying NixOS experience
- [ ] T021 [US1] Conduct user testing session for installation flow
- [ ] T022 [US1] Iterate on documentation based on user feedback
- [ ] T023 [US1] Validate installation completes in <60 minutes (SC-001)

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Existing User Profile Management (Priority: P2)

**Goal**: Complete profile management documentation for daily operations

**Independent Test**: A user can identify the appropriate profile and successfully switch to it using documented commands

### Implementation for User Story 2

- [x] T024 [P] [US2] Write `docs/end-user/profiles-overview.md` with profile comparison
- [x] T025 [P] [US2] Write `docs/end-user/profile-switching.md` with switch commands
- [x] T026 [US2] Test all commands in profiles-overview.md (execute and verify)
- [x] T027 [US2] Test all commands in profile-switching.md (execute and verify)
- [x] T028 [US2] Add troubleshooting section for profile switch failures
- [x] T029 [US2] Add expected output examples for each command
- [ ] T030 [US2] Conduct user testing session for profile switching flow
- [ ] T031 [US2] Iterate on documentation based on user feedback
- [ ] T032 [US2] Validate users find answers within 2 minutes (SC-004)

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: User Story 3 - Developer/Contributor Onboarding (Priority: P3)

**Goal**: Complete contributor documentation for extending the codebase

**Independent Test**: A developer can add a new host, module, or profile following documentation and pass all linting/validation checks

### Implementation for User Story 3

- [x] T033 [P] [US3] Write `docs/developer/adding-host.md` with step-by-step guide
- [x] T034 [P] [US3] Write `docs/developer/adding-module.md` with module structure
- [x] T035 [P] [US3] Write `docs/developer/adding-profile.md` with profile composition
- [x] T036 [P] [US3] Write `docs/contributor/workflows.md` with development workflows
- [x] T037 [US3] Test all commands in adding-host.md (execute and verify)
- [x] T038 [US3] Test all commands in adding-module.md (execute and verify)
- [x] T039 [US3] Test all commands in adding-profile.md (execute and verify)
- [x] T040 [US3] Test all commands in workflows.md (execute and verify)
- [x] T041 [US3] Add troubleshooting section for common development errors
- [ ] T042 [US3] Validate new host builds successfully following documentation
- [ ] T043 [US3] Validate new profile switches successfully following documentation

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T044 [P] Create `docs/SUMMARY.md` with complete table of contents
- [ ] T045 [P] Add cross-references between related documentation sections
- [ ] T046 Documentation consistency review (terminology, formatting, tone)
- [ ] T047 Validate all links resolve correctly (SC-006)
- [ ] T048 [P] Create Phase 2 plan for comprehensive documentation (architecture, migration guides)
- [ ] T049 Run final validation against requirements-quality checklist
- [ ] T050 Gather final user feedback and document satisfaction metrics (SC-007)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Phase 6)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - Independent of US1
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - Independent of US1/US2

### Within Each User Story

- Models/documentation before testing
- Core documentation before troubleshooting sections
- Command testing before user feedback sessions
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel (T003, T004, T005)
- All Foundational tasks can run in parallel within Phase 2
- Once Foundational phase completes, all user stories can start in parallel (if team capacity allows)
- All documentation files within a user story marked [P] can run in parallel
- Different user stories can be worked on in parallel by different writers

---

## Parallel Example: User Story 1

```bash
# Launch all documentation files for User Story 1 together:
Task: "Write docs/end-user/installation.md"
Task: "Write docs/end-user/new-host-setup.md"
Task: "Write docs/end-user/secrets-management.md"

# After documentation complete, test all commands:
Task: "Test all commands in installation.md"
Task: "Test all commands in new-host-setup.md"
Task: "Test all commands in secrets-management.md"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (delete old docs, create directories)
2. Complete Phase 2: Foundational (navigation, validation protocol)
3. Complete Phase 3: User Story 1 (installation documentation)
4. **STOP and VALIDATE**: Test installation flow with 3 users
5. Deploy/documentation ready for use

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Documentation live (MVP!)
3. Add User Story 2 → Test independently → Documentation live
4. Add User Story 3 → Test independently → Documentation live
5. Each documentation section adds value without breaking previous sections

### Parallel Team Strategy

With multiple documentation writers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Writer A: User Story 1 (Installation)
   - Writer B: User Story 2 (Profile Management)
   - Writer C: User Story 3 (Developer Onboarding)
3. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Test commands BEFORE writing user feedback sessions
- Commit after each task or logical group
- Stop at any checkpoint to validate story independently
- Avoid: vague documentation, untested commands, cross-story dependencies

---

## Task Summary

**Total Tasks**: 50

| Phase | Task Count | Focus |
|-------|------------|-------|
| Phase 1: Setup | 6 | Directory structure, style guide |
| Phase 2: Foundational | 5 | Navigation, validation protocols |
| Phase 3: User Story 1 | 12 | Installation documentation + testing |
| Phase 4: User Story 2 | 9 | Profile management documentation + testing |
| Phase 5: User Story 3 | 11 | Developer onboarding documentation + testing |
| Phase 6: Polish | 7 | Cross-cutting improvements |

**MVP Scope**: Phases 1-3 (23 tasks) - Installation documentation ready for use

**Parallel Opportunities**: 
- Setup tasks (T003-T005)
- Documentation files within each story
- User stories can proceed in parallel after Phase 2
